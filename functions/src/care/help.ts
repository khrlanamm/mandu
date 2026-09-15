import {Timestamp} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {consumeRateLimit, rateLimitKey} from "../core/rateLimit";
import {memberRef, schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {
  CONTACT_METHODS,
  CONTACT_TIMES,
  HELP_NEED_KEYS,
  HELP_URGENCIES,
  HELP_URGENCY_LABELS,
  staffHelpRoute,
  studentHelpRoute,
  type HelpRequestDoc,
} from "../domain/care";
import type {MemberDoc, SchoolDoc} from "../domain/models";
import {notifyUsers, roleUids} from "../notifications/notify";
import {staffName} from "../tickets/access";
import {createConversation} from "./conversations";

const ids = {schoolId: z.string().min(1), requestId: z.string().min(1)};

export const helpRequestsRef = (schoolId: string) => schoolRef(schoolId).collection("helpRequests");

const requestSchema = z.object({
  schoolId: z.string().min(1),
  needs: z.array(z.enum(HELP_NEED_KEYS as [string, ...string[]])).min(1, "Pilih setidaknya satu kebutuhan.").max(HELP_NEED_KEYS.length),
  urgency: z.enum(HELP_URGENCIES),
  contactMethod: z.enum(CONTACT_METHODS),
  contactTime: z.enum(CONTACT_TIMES),
  whatsapp: z.string().trim().regex(/^\+?\d{9,15}$/, "Nomor WhatsApp tidak valid.").nullable().optional(),
  note: z.string().trim().max(1000).nullable().optional(),
}).refine((input) => input.contactMethod !== "whatsapp" || !!input.whatsapp, {
  message: "Isi nomor WhatsApp untuk dihubungi lewat WhatsApp.",
  path: ["whatsapp"],
});

const jakartaYear = (date: Date) => new Intl.DateTimeFormat("en", {timeZone: "Asia/Jakarta", year: "numeric"}).format(date);

async function requireCounselor(caller: Caller, schoolId: string): Promise<string> {
  if (caller.claims.sid !== schoolId || caller.claims.role !== "konselor") {
    throw new AppError("permission-denied", "Hanya konselor sekolah ini yang dapat menangani permintaan bantuan.");
  }
  return staffName(caller, schoolId);
}

/** Siswa meminta bantuan tanpa harus menjelaskan panjang lebar. */
export async function requestHelp(caller: Caller, data: unknown): Promise<{requestId: string; number: string}> {
  const input = parsePayload(requestSchema, data);
  const {schoolId} = input;
  if (caller.claims.sid !== schoolId || caller.claims.role !== "siswa") {
    throw new AppError("permission-denied", "Hanya siswa aktif sekolah ini yang dapat meminta bantuan.");
  }
  const [school, member] = await Promise.all([
    schoolRef(schoolId).get().then((snapshot) => snapshot.data() as SchoolDoc | undefined),
    memberRef(schoolId, caller.uid).get().then((snapshot) => snapshot.data() as MemberDoc | undefined),
  ]);
  if (!school?.active || !school.services.bantuan) throw new AppError("failed-precondition", "Layanan Butuh Bantuan sedang dinonaktifkan.");
  if (member?.status !== "active") throw new AppError("permission-denied", "Keanggotaanmu di sekolah ini belum aktif.");
  await consumeRateLimit(rateLimitKey("bantuan", caller.uid), 5, 24 * 3_600_000, "Kamu sudah mengirim 5 permintaan hari ini. Hubungi guru BK langsung bila mendesak.");

  const ref = helpRequestsRef(schoolId).doc();
  const now = Timestamp.now();
  const number = await db().runTransaction(async (tx) => {
    const counterRef = schoolRef(schoolId).collection("counters").doc("help");
    const year = jakartaYear(now.toDate());
    const sequence = (((await tx.get(counterRef)).get(year) as number | undefined) ?? 0) + 1;
    const requestNumber = `HLP-${year}-${String(sequence).padStart(4, "0")}`;
    const doc: HelpRequestDoc = {
      number: requestNumber,
      schoolId,
      studentUid: caller.uid,
      student: {name: member.displayName, kelas: member.kelas},
      needs: input.needs,
      urgency: input.urgency,
      contactMethod: input.contactMethod,
      contactTime: input.contactTime,
      whatsapp: input.whatsapp ?? null,
      note: input.note || null,
      status: "menunggu",
      counselorUid: null,
      counselorName: null,
      conversationId: null,
      closingNote: null,
      createdAt: now,
      updatedAt: now,
      claimedAt: null,
      closedAt: null,
    };
    tx.set(counterRef, {[year]: sequence}, {merge: true});
    tx.create(ref, doc);
    return requestNumber;
  });

  const urgent = input.urgency !== "biasa";
  await notifyUsers(await roleUids(schoolId, ["konselor"]), {
    type: "bantuan_baru",
    title: input.urgency === "darurat" ? `DARURAT · Permintaan bantuan ${number}` : `Permintaan bantuan ${number}`,
    body: `Siswa membutuhkan bantuan (${HELP_URGENCY_LABELS[input.urgency].toLowerCase()}).`,
    route: staffHelpRoute(ref.id),
    schoolId,
    urgent,
  });
  if (input.urgency === "darurat") {
    // Admin hanya diberi tahu tanpa isi permintaan agar bisa memastikan konselor merespons.
    await notifyUsers(await roleUids(schoolId, ["admin"]), {
      type: "bantuan_darurat",
      title: "Ada permintaan bantuan darurat",
      body: "Pastikan konselor sekolah segera merespons.",
      route: "/staff",
      schoolId,
      urgent: true,
    });
  }
  return {requestId: ref.id, number};
}

/** Konselor mengambil permintaan; bila siswa memilih chat, percakapan Curhat langsung dibuka. */
export async function claimHelp(caller: Caller, data: unknown): Promise<{conversationId: string | null}> {
  const {schoolId, requestId} = parsePayload(z.object(ids), data);
  const counselorName = await requireCounselor(caller, schoolId);
  const ref = helpRequestsRef(schoolId).doc(requestId);

  const request = await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as HelpRequestDoc | undefined;
    if (!current) throw new AppError("not-found", "Permintaan bantuan tidak ditemukan.");
    if (current.status !== "menunggu") throw new AppError("failed-precondition", "Permintaan ini sudah ditangani konselor lain.");
    const now = Timestamp.now();
    tx.update(ref, {status: "ditangani", counselorUid: caller.uid, counselorName, claimedAt: now, updatedAt: now});
    return current;
  });

  let conversationId: string | null = null;
  if (request.contactMethod === "chat") {
    conversationId = await createConversation({
      schoolId,
      studentUid: request.studentUid,
      displayName: request.student.name,
      identity: request.student,
      counselor: {uid: caller.uid, name: counselorName},
      topic: "Butuh Bantuan",
      helpRequestId: requestId,
      opening: {senderUid: caller.uid, senderRole: "konselor", text: `Halo, saya ${counselorName}. Saya sudah membaca permintaan bantuanmu. Ceritakan kapan pun kamu siap, ya.`},
    });
    await ref.update({conversationId});
  }

  await notifyUsers([request.studentUid], {
    type: "bantuan_ditangani",
    title: `${counselorName} akan membantumu`,
    body: request.contactMethod === "chat" ? "Buka percakapan untuk mulai bercerita." : "Konselor akan menghubungimu sesuai pilihanmu.",
    route: conversationId ? `/home/curhat/${conversationId}` : studentHelpRoute(requestId),
    schoolId,
    urgent: request.urgency !== "biasa",
  });
  return {conversationId};
}

/** Konselor menutup permintaan yang ditanganinya dengan pesan penutup untuk siswa. */
export async function closeHelp(caller: Caller, data: unknown): Promise<{status: "selesai"}> {
  const {schoolId, requestId, note} = parsePayload(
    z.object({...ids, note: z.string().trim().min(5, "Tuliskan pesan penutup minimal 5 karakter.").max(1000)}),
    data,
  );
  await requireCounselor(caller, schoolId);
  const ref = helpRequestsRef(schoolId).doc(requestId);
  const request = await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as HelpRequestDoc | undefined;
    if (!current) throw new AppError("not-found", "Permintaan bantuan tidak ditemukan.");
    if (current.counselorUid !== caller.uid) throw new AppError("permission-denied", "Permintaan ini ditangani konselor lain.");
    if (current.status !== "ditangani") throw new AppError("failed-precondition", "Permintaan ini tidak sedang ditangani.");
    const now = Timestamp.now();
    tx.update(ref, {status: "selesai", closingNote: note, closedAt: now, updatedAt: now});
    return current;
  });
  await notifyUsers([request.studentUid], {
    type: "bantuan_selesai",
    title: "Permintaan bantuan ditutup",
    body: note.slice(0, 120),
    route: studentHelpRoute(requestId),
    schoolId,
  });
  return {status: "selesai"};
}

/** Siswa membatalkan permintaan yang belum diambil konselor. */
export async function cancelHelp(caller: Caller, data: unknown): Promise<{status: "dibatalkan"}> {
  const {schoolId, requestId} = parsePayload(z.object(ids), data);
  const ref = helpRequestsRef(schoolId).doc(requestId);
  await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as HelpRequestDoc | undefined;
    if (!current || current.studentUid !== caller.uid) throw new AppError("not-found", "Permintaan bantuan tidak ditemukan.");
    if (current.status !== "menunggu") throw new AppError("failed-precondition", "Permintaan sudah ditangani konselor.");
    const now = Timestamp.now();
    tx.update(ref, {status: "dibatalkan", closedAt: now, updatedAt: now});
  });
  return {status: "dibatalkan"};
}
