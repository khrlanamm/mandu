import {FieldValue, Timestamp} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {consumeRateLimit, rateLimitKey} from "../core/rateLimit";
import {memberRef, schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {
  staffConversationRoute,
  studentConversationRoute,
  type ConversationDoc,
  type MessageDoc,
} from "../domain/care";
import type {MemberDoc, SchoolDoc} from "../domain/models";
import {notifyUsers, roleUids} from "../notifications/notify";
import {staffName} from "../tickets/access";

export const conversationsRef = (schoolId: string) => schoolRef(schoolId).collection("conversations");

const ids = {schoolId: z.string().min(1), conversationId: z.string().min(1)};

function systemMessage(text: string, sender: Pick<MessageDoc, "senderUid" | "senderRole"> = {senderUid: null, senderRole: "sistem"}): MessageDoc {
  return {...sender, text, imagePath: null, createdAt: Timestamp.now(), silent: true};
}

interface NewConversation {
  schoolId: string;
  studentUid: string;
  displayName: string;
  /** Nama & kelas asli; null bila siswa memakai nama samaran. */
  identity: {name: string; kelas: string | null} | null;
  counselor: {uid: string; name: string} | null;
  topic: string | null;
  helpRequestId: string | null;
  opening: Pick<MessageDoc, "senderUid" | "senderRole" | "text">;
}

/** Buat percakapan beserta pesan pembuka (dipakai Curhat dan Butuh Bantuan). */
export async function createConversation(input: NewConversation): Promise<string> {
  const ref = conversationsRef(input.schoolId).doc();
  const now = Timestamp.now();
  const fromStudent = input.opening.senderRole === "siswa";
  const doc: ConversationDoc = {
    schoolId: input.schoolId,
    studentUid: input.studentUid,
    displayName: input.displayName,
    usesAlias: input.identity === null,
    identityRevealed: input.identity !== null,
    counselorUid: input.counselor?.uid ?? null,
    counselorName: input.counselor?.name ?? null,
    status: input.counselor ? "aktif" : "menunggu",
    topic: input.topic,
    lastMessage: {text: input.opening.text.slice(0, 200), senderRole: input.opening.senderRole, at: now},
    unreadStudent: fromStudent ? 0 : 1,
    unreadCounselor: fromStudent ? 1 : 0,
    meeting: null,
    helpRequestId: input.helpRequestId,
    createdAt: now,
    updatedAt: now,
    closedAt: null,
  };
  const batch = db().batch();
  batch.create(ref, doc);
  if (input.identity) batch.create(ref.collection("private").doc("identity"), input.identity);
  batch.create(ref.collection("messages").doc(), {...systemMessage(input.opening.text, input.opening), silent: true});
  await batch.commit();
  return ref.id;
}

async function loadConversation(schoolId: string, conversationId: string): Promise<ConversationDoc> {
  const conversation = (await conversationsRef(schoolId).doc(conversationId).get()).data() as ConversationDoc | undefined;
  if (!conversation) throw new AppError("not-found", "Percakapan tidak ditemukan.");
  return conversation;
}

/** Konselor aktif sekolah yang bisa dipilih siswa. */
export async function listCounselors(caller: Caller, data: unknown): Promise<{counselors: {uid: string; name: string}[]}> {
  const {schoolId} = parsePayload(z.object({schoolId: z.string().min(1)}), data);
  if (caller.claims.sid !== schoolId) throw new AppError("permission-denied", "Kamu bukan anggota sekolah ini.");
  const snapshot = await schoolRef(schoolId).collection("members").where("role", "==", "konselor").where("status", "==", "active").get();
  const counselors = snapshot.docs
    .map((doc) => doc.data() as MemberDoc)
    .map((member) => ({uid: member.uid, name: member.displayName}))
    .sort((a, b) => a.name.localeCompare(b.name));
  return {counselors};
}

const startSchema = z.object({
  schoolId: z.string().min(1),
  counselorUid: z.string().min(1).nullable(),
  alias: z.string().trim().min(2, "Nama samaran minimal 2 karakter.").max(40).nullable().optional(),
  topic: z.string().trim().max(60).nullable().optional(),
  message: z.string().trim().min(1, "Tulis pesan pertamamu.").max(2000),
});

/** Siswa memulai Curhat dengan konselor tertentu atau siapa saja yang tersedia. */
export async function startConversation(caller: Caller, data: unknown): Promise<{conversationId: string}> {
  const input = parsePayload(startSchema, data);
  const {schoolId} = input;
  if (caller.claims.sid !== schoolId || caller.claims.role !== "siswa") {
    throw new AppError("permission-denied", "Hanya siswa aktif sekolah ini yang dapat memulai curhat.");
  }
  const [school, member] = await Promise.all([
    schoolRef(schoolId).get().then((snapshot) => snapshot.data() as SchoolDoc | undefined),
    memberRef(schoolId, caller.uid).get().then((snapshot) => snapshot.data() as MemberDoc | undefined),
  ]);
  if (!school?.active || !school.services.curhat) throw new AppError("failed-precondition", "Layanan Curhat sedang dinonaktifkan.");
  if (member?.status !== "active") throw new AppError("permission-denied", "Keanggotaanmu di sekolah ini belum aktif.");

  let counselor: {uid: string; name: string} | null = null;
  if (input.counselorUid) {
    const chosen = (await memberRef(schoolId, input.counselorUid).get()).data() as MemberDoc | undefined;
    if (chosen?.role !== "konselor" || chosen.status !== "active") throw new AppError("invalid-argument", "Konselor tidak ditemukan.");
    counselor = {uid: input.counselorUid, name: chosen.displayName};
  }
  await consumeRateLimit(rateLimitKey("curhat", caller.uid), 10, 24 * 3_600_000, "Kamu sudah memulai 10 percakapan hari ini. Lanjutkan percakapan yang ada, ya.");

  const alias = input.alias || null;
  const conversationId = await createConversation({
    schoolId,
    studentUid: caller.uid,
    displayName: alias ?? member.displayName,
    identity: alias ? null : {name: member.displayName, kelas: member.kelas},
    counselor,
    topic: input.topic || null,
    helpRequestId: null,
    opening: {senderUid: caller.uid, senderRole: "siswa", text: input.message},
  });

  const recipients = counselor ? [counselor.uid] : await roleUids(schoolId, ["konselor"]);
  await notifyUsers(recipients, {
    type: "curhat_baru",
    title: counselor ? "Ada siswa yang ingin bercerita" : "Curhat baru menunggu konselor",
    body: `${alias ?? member.displayName} memulai percakapan. Isi pesan hanya terlihat di aplikasi.`,
    route: staffConversationRoute(conversationId),
    schoolId,
  });
  return {conversationId};
}

/** Konselor mengambil percakapan yang belum punya konselor. */
export async function claimConversation(caller: Caller, data: unknown): Promise<{status: "aktif"}> {
  const {schoolId, conversationId} = parsePayload(z.object(ids), data);
  if (caller.claims.sid !== schoolId || caller.claims.role !== "konselor") {
    throw new AppError("permission-denied", "Hanya konselor yang dapat mengambil percakapan.");
  }
  const counselorName = await staffName(caller, schoolId);
  const ref = conversationsRef(schoolId).doc(conversationId);
  const conversation = await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as ConversationDoc | undefined;
    if (!current) throw new AppError("not-found", "Percakapan tidak ditemukan.");
    if (current.status !== "menunggu" || current.counselorUid) {
      throw new AppError("failed-precondition", "Percakapan ini sudah diambil konselor lain.");
    }
    tx.update(ref, {counselorUid: caller.uid, counselorName, status: "aktif", updatedAt: Timestamp.now()});
    tx.create(ref.collection("messages").doc(), systemMessage(`${counselorName} bergabung dalam percakapan.`));
    return current;
  });
  await notifyUsers([conversation.studentUid], {
    type: "curhat_diambil",
    title: `${counselorName} siap mendengarkan`,
    body: "Konselor sudah bergabung dalam percakapanmu.",
    route: studentConversationRoute(conversationId),
    schoolId,
  });
  return {status: "aktif"};
}

/** Siswa atau konselor yang menangani menutup percakapan. */
export async function closeConversation(caller: Caller, data: unknown): Promise<{status: "selesai"}> {
  const {schoolId, conversationId} = parsePayload(z.object(ids), data);
  const ref = conversationsRef(schoolId).doc(conversationId);
  const {conversation, byStudent} = await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as ConversationDoc | undefined;
    const student = current?.studentUid === caller.uid;
    const counselor = !!current?.counselorUid && current.counselorUid === caller.uid;
    if (!current || (!student && !counselor)) throw new AppError("not-found", "Percakapan tidak ditemukan.");
    if (current.status === "selesai") throw new AppError("failed-precondition", "Percakapan sudah ditutup.");
    const now = Timestamp.now();
    tx.update(ref, {status: "selesai", closedAt: now, updatedAt: now});
    tx.create(ref.collection("messages").doc(), systemMessage(student ? "Siswa menutup percakapan." : `${current.counselorName} menutup percakapan.`));
    return {conversation: current, byStudent: student};
  });
  const other = byStudent ? conversation.counselorUid : conversation.studentUid;
  if (other) {
    await notifyUsers([other], {
      type: "curhat_selesai",
      title: "Percakapan curhat ditutup",
      body: byStudent ? `${conversation.displayName} menutup percakapan.` : "Terima kasih sudah bercerita. Kamu bisa memulai curhat baru kapan saja.",
      route: byStudent ? staffConversationRoute(conversationId) : studentConversationRoute(conversationId),
      schoolId,
      inbox: true,
    });
  }
  return {status: "selesai"};
}

/** Siswa yang memakai nama samaran membuka identitas aslinya kepada konselor. */
export async function revealIdentity(caller: Caller, data: unknown): Promise<{displayName: string}> {
  const {schoolId, conversationId} = parsePayload(z.object(ids), data);
  const conversation = await loadConversation(schoolId, conversationId);
  if (conversation.studentUid !== caller.uid) throw new AppError("not-found", "Percakapan tidak ditemukan.");
  if (conversation.identityRevealed) return {displayName: conversation.displayName};
  const member = (await memberRef(schoolId, caller.uid).get()).data() as MemberDoc;

  const ref = conversationsRef(schoolId).doc(conversationId);
  const batch = db().batch();
  batch.update(ref, {displayName: member.displayName, identityRevealed: true, updatedAt: Timestamp.now()});
  batch.set(ref.collection("private").doc("identity"), {name: member.displayName, kelas: member.kelas});
  batch.create(ref.collection("messages").doc(), systemMessage(`Siswa membuka identitasnya: ${member.displayName}${member.kelas ? `, kelas ${member.kelas}` : ""}.`));
  await batch.commit();
  return {displayName: member.displayName};
}

const meetingSchema = z.object({
  ...ids,
  at: z.string().datetime({offset: true, message: "Waktu temu tidak valid."}),
  place: z.string().trim().min(2, "Isi tempat bertemu.").max(120),
});

/** Konselor mengusulkan jadwal temu tatap muka. */
export async function proposeMeeting(caller: Caller, data: unknown): Promise<{ok: true}> {
  const input = parsePayload(meetingSchema, data);
  const conversation = await loadConversation(input.schoolId, input.conversationId);
  if (conversation.counselorUid !== caller.uid) throw new AppError("permission-denied", "Hanya konselor yang menangani yang dapat mengusulkan jadwal.");
  if (conversation.status !== "aktif") throw new AppError("failed-precondition", "Percakapan tidak aktif.");
  const at = Timestamp.fromDate(new Date(input.at));
  if (at.toMillis() < Date.now()) throw new AppError("invalid-argument", "Jadwal temu harus di waktu yang akan datang.");

  const ref = conversationsRef(input.schoolId).doc(input.conversationId);
  const when = new Intl.DateTimeFormat("id-ID", {dateStyle: "full", timeStyle: "short", timeZone: "Asia/Jakarta"}).format(at.toDate());
  const batch = db().batch();
  batch.update(ref, {meeting: {at, place: input.place, status: "diusulkan"}, updatedAt: Timestamp.now()});
  batch.create(ref.collection("messages").doc(), systemMessage(`${conversation.counselorName} mengusulkan bertemu ${when} WIB di ${input.place}.`));
  await batch.commit();
  await notifyUsers([conversation.studentUid], {
    type: "curhat_jadwal",
    title: "Usulan jadwal temu dengan konselor",
    body: `${when} WIB · ${input.place}`,
    route: studentConversationRoute(input.conversationId),
    schoolId: input.schoolId,
  });
  return {ok: true};
}

/** Siswa menyetujui atau menolak usulan jadwal temu. */
export async function respondMeeting(caller: Caller, data: unknown): Promise<{status: string}> {
  const {schoolId, conversationId, accept} = parsePayload(z.object({...ids, accept: z.boolean()}), data);
  const conversation = await loadConversation(schoolId, conversationId);
  if (conversation.studentUid !== caller.uid) throw new AppError("not-found", "Percakapan tidak ditemukan.");
  if (conversation.meeting?.status !== "diusulkan") throw new AppError("failed-precondition", "Tidak ada usulan jadwal yang menunggu jawaban.");
  const status = accept ? "disetujui" : "ditolak";
  const ref = conversationsRef(schoolId).doc(conversationId);
  const batch = db().batch();
  batch.update(ref, {"meeting.status": status, "updatedAt": Timestamp.now()});
  batch.create(ref.collection("messages").doc(), systemMessage(accept ? "Siswa menyetujui jadwal temu." : "Siswa belum bisa pada jadwal tersebut."));
  await batch.commit();
  if (conversation.counselorUid) {
    await notifyUsers([conversation.counselorUid], {
      type: "curhat_jadwal",
      title: accept ? "Jadwal temu disetujui" : "Jadwal temu ditolak",
      body: `${conversation.displayName} ${accept ? "menyetujui" : "belum bisa pada"} jadwal yang diusulkan.`,
      route: staffConversationRoute(conversationId),
      schoolId,
    });
  }
  return {status};
}

/**
 * Trigger pesan baru dari aplikasi: perbarui ringkasan percakapan dan kirim push ke pihak lain.
 * Push tidak memuat isi pesan dan tidak masuk kotak notifikasi (supaya tidak menumpuk).
 */
export async function onConversationMessage(schoolId: string, conversationId: string, message: MessageDoc): Promise<void> {
  if (message.silent || message.senderRole === "sistem") return;
  const ref = conversationsRef(schoolId).doc(conversationId);
  const conversation = (await ref.get()).data() as ConversationDoc | undefined;
  if (!conversation) return;

  const fromStudent = message.senderRole === "siswa";
  await ref.update({
    lastMessage: {text: message.text ? message.text.slice(0, 200) : "📷 Gambar", senderRole: message.senderRole, at: message.createdAt},
    updatedAt: FieldValue.serverTimestamp(),
    [fromStudent ? "unreadCounselor" : "unreadStudent"]: FieldValue.increment(1),
  });

  const recipient = fromStudent ? conversation.counselorUid : conversation.studentUid;
  if (!recipient) return;
  await notifyUsers([recipient], {
    type: "pesan_curhat",
    title: fromStudent ? `Pesan dari ${conversation.displayName}` : `Pesan dari ${conversation.counselorName ?? "konselor"}`,
    body: "Ketuk untuk membaca pesan.",
    route: fromStudent ? staffConversationRoute(conversationId) : studentConversationRoute(conversationId),
    schoolId,
    inbox: false,
  });
}
