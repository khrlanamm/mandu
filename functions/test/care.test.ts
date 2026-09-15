import {Timestamp} from "firebase-admin/firestore";
import {beforeEach, describe, expect, it} from "vitest";
import {
  claimConversation,
  closeConversation,
  listCounselors,
  onConversationMessage,
  proposeMeeting,
  respondMeeting,
  revealIdentity,
  startConversation,
} from "../src/care/conversations";
import {cancelHelp, claimHelp, closeHelp, requestHelp} from "../src/care/help";
import type {MessageDoc} from "../src/domain/care";
import {createSchool} from "../src/schools/manage";
import {SUPERADMIN, addMember, db, resetEmulators} from "./helpers";

async function setupSchool() {
  const {schoolId} = await createSchool(SUPERADMIN, {name: "SMA Peduli", level: "SMA", city: "Lamongan", province: "Jawa Timur", code: "PEDULI"});
  return {
    schoolId,
    admin: await addMember(schoolId, "admin", {displayName: "Andi Admin", role: "admin"}),
    bk: await addMember(schoolId, "bk", {displayName: "Sri Wahyuni", role: "konselor", units: ["bk_ppks"], canVerify: true}),
    bk2: await addMember(schoolId, "bk2", {displayName: "Rahmat Hidayat", role: "konselor", units: ["bk_ppks"]}),
    sarpras: await addMember(schoolId, "sarpras", {displayName: "Joko Sarpras", role: "petugas", units: ["sarpras"]}),
    siswa: await addMember(schoolId, "siswa", {displayName: "Budi Santoso", role: "siswa", kelas: "XI IPA 1"}),
    siswa2: await addMember(schoolId, "siswa2", {displayName: "Siti Aminah", role: "siswa", kelas: "X-2"}),
  };
}

const helpInput = (schoolId: string, overrides: Record<string, unknown> = {}) => ({
  schoolId,
  needs: ["ingin_bicara", "perasaan"],
  urgency: "biasa",
  contactMethod: "chat",
  contactTime: "istirahat",
  ...overrides,
});

const notificationsOf = async (uid: string) => (await db.collection(`users/${uid}/notifications`).get()).docs.map((doc) => doc.data());
const conversationOf = async (schoolId: string, id: string) => (await db.doc(`schools/${schoolId}/conversations/${id}`).get()).data()!;
const messagesOf = async (schoolId: string, id: string) =>
  (await db.collection(`schools/${schoolId}/conversations/${id}/messages`).orderBy("createdAt").get()).docs.map((doc) => doc.data());

describe("layanan Butuh Bantuan", () => {
  beforeEach(resetEmulators);

  it("permintaan darurat memberi tahu konselor dan admin tanpa membocorkan isi", async () => {
    const school = await setupSchool();
    const result = await requestHelp(school.siswa, helpInput(school.schoolId, {urgency: "darurat"}));

    expect(result.number).toMatch(/^HLP-\d{4}-0001$/);
    expect((await notificationsOf("bk"))[0]).toMatchObject({type: "bantuan_baru", urgent: true});
    expect(await notificationsOf("bk2")).toHaveLength(1);
    const [adminNotification] = await notificationsOf("admin");
    expect(adminNotification).toMatchObject({type: "bantuan_darurat", route: "/staff"});
    expect(adminNotification.body).not.toContain("ingin_bicara");
    expect(await notificationsOf("sarpras")).toHaveLength(0);
  });

  it("nomor WhatsApp wajib bila siswa memilih dihubungi lewat WhatsApp", async () => {
    const school = await setupSchool();
    await expect(requestHelp(school.siswa, helpInput(school.schoolId, {contactMethod: "whatsapp"})))
      .rejects.toMatchObject({code: "invalid-argument"});
    await expect(requestHelp(school.siswa, helpInput(school.schoolId, {contactMethod: "whatsapp", whatsapp: "081234567890"})))
      .resolves.toMatchObject({number: expect.stringContaining("HLP-")});
    await expect(requestHelp(school.sarpras, helpInput(school.schoolId))).rejects.toMatchObject({code: "permission-denied"});
  });

  it("konselor mengambil permintaan chat lalu menutupnya; satu permintaan satu konselor", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {requestId} = await requestHelp(school.siswa, helpInput(schoolId));

    const claimed = await claimHelp(school.bk, {schoolId, requestId});
    expect(claimed.conversationId).toBeTruthy();
    await expect(claimHelp(school.bk2, {schoolId, requestId})).rejects.toMatchObject({code: "failed-precondition"});
    await expect(claimHelp(school.sarpras, {schoolId, requestId})).rejects.toMatchObject({code: "permission-denied"});

    const conversation = await conversationOf(schoolId, claimed.conversationId!);
    expect(conversation).toMatchObject({
      status: "aktif",
      counselorUid: "bk",
      displayName: "Budi Santoso",
      identityRevealed: true,
      helpRequestId: requestId,
    });
    expect((await messagesOf(schoolId, claimed.conversationId!))[0].text).toContain("Sri Wahyuni");
    expect((await notificationsOf("siswa"))[0]).toMatchObject({type: "bantuan_ditangani"});

    await expect(closeHelp(school.bk2, {schoolId, requestId, note: "Sudah saya bantu."})).rejects.toMatchObject({code: "permission-denied"});
    await closeHelp(school.bk, {schoolId, requestId, note: "Sudah bertemu dan akan dipantau minggu depan."});
    expect((await db.doc(`schools/${schoolId}/helpRequests/${requestId}`).get()).data())
      .toMatchObject({status: "selesai", counselorName: "Sri Wahyuni"});
  });

  it("siswa membatalkan permintaan yang belum diambil", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {requestId} = await requestHelp(school.siswa2, helpInput(schoolId, {contactMethod: "bertemu"}));

    await expect(cancelHelp(school.siswa, {schoolId, requestId})).rejects.toMatchObject({code: "not-found"});
    await cancelHelp(school.siswa2, {schoolId, requestId});
    expect((await db.doc(`schools/${schoolId}/helpRequests/${requestId}`).get()).get("status")).toBe("dibatalkan");
    await expect(claimHelp(school.bk, {schoolId, requestId})).rejects.toMatchObject({code: "failed-precondition"});
  });
});

describe("layanan Curhat", () => {
  beforeEach(resetEmulators);

  it("siswa memakai nama samaran, konselor mengambil, lalu identitas dibuka", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    expect((await listCounselors(school.siswa, {schoolId})).counselors).toEqual([
      {uid: "bk2", name: "Rahmat Hidayat"},
      {uid: "bk", name: "Sri Wahyuni"},
    ]);

    const {conversationId} = await startConversation(school.siswa, {
      schoolId,
      counselorUid: null,
      alias: "Bunga",
      topic: "Pertemanan",
      message: "Aku sedang bingung dengan teman-teman di kelas.",
    });
    expect(await conversationOf(schoolId, conversationId)).toMatchObject({
      status: "menunggu",
      displayName: "Bunga",
      usesAlias: true,
      identityRevealed: false,
      unreadCounselor: 1,
    });
    expect((await db.doc(`schools/${schoolId}/conversations/${conversationId}/private/identity`).get()).exists).toBe(false);
    expect(await notificationsOf("bk")).toHaveLength(1);
    expect(await notificationsOf("bk2")).toHaveLength(1);

    await claimConversation(school.bk, {schoolId, conversationId});
    await expect(claimConversation(school.bk2, {schoolId, conversationId})).rejects.toMatchObject({code: "failed-precondition"});
    expect(await conversationOf(schoolId, conversationId)).toMatchObject({status: "aktif", counselorUid: "bk", counselorName: "Sri Wahyuni"});

    await revealIdentity(school.siswa, {schoolId, conversationId});
    expect(await conversationOf(schoolId, conversationId)).toMatchObject({displayName: "Budi Santoso", identityRevealed: true});
    expect((await db.doc(`schools/${schoolId}/conversations/${conversationId}/private/identity`).get()).data())
      .toEqual({name: "Budi Santoso", kelas: "XI IPA 1"});
    await expect(revealIdentity(school.siswa2, {schoolId, conversationId})).rejects.toMatchObject({code: "not-found"});
  });

  it("pesan baru memperbarui ringkasan dan hanya mengirim push tanpa kotak masuk", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {conversationId} = await startConversation(school.siswa, {
      schoolId,
      counselorUid: "bk",
      alias: null,
      message: "Halo Bu, boleh cerita?",
    });
    const inboxBefore = (await notificationsOf("bk")).length;

    const message: MessageDoc = {senderUid: "siswa", senderRole: "siswa", text: "Aku takut dimarahi kalau cerita.", imagePath: null, createdAt: Timestamp.now()};
    await onConversationMessage(schoolId, conversationId, message);

    const conversation = await conversationOf(schoolId, conversationId);
    expect(conversation.lastMessage).toMatchObject({text: "Aku takut dimarahi kalau cerita.", senderRole: "siswa"});
    expect(conversation.unreadCounselor).toBe(2);
    expect(await notificationsOf("bk")).toHaveLength(inboxBefore);

    await onConversationMessage(schoolId, conversationId, {...message, senderUid: "bk", senderRole: "konselor", text: "Tentu, ceritakan pelan-pelan ya."});
    expect((await conversationOf(schoolId, conversationId)).unreadStudent).toBe(1);
    // Pesan sistem tidak menambah hitungan belum dibaca.
    await onConversationMessage(schoolId, conversationId, {...message, senderUid: null, senderRole: "sistem", text: "Konselor bergabung."});
    expect((await conversationOf(schoolId, conversationId)).unreadStudent).toBe(1);
  });

  it("jadwal temu diusulkan konselor dan dijawab siswa; percakapan bisa ditutup", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {conversationId} = await startConversation(school.siswa, {schoolId, counselorUid: "bk", alias: null, message: "Bu, saya ingin konsultasi."});
    const besok = new Date(Date.now() + 86_400_000).toISOString();

    await expect(proposeMeeting(school.bk2, {schoolId, conversationId, at: besok, place: "Ruang BK"}))
      .rejects.toMatchObject({code: "permission-denied"});
    await expect(proposeMeeting(school.bk, {schoolId, conversationId, at: new Date(Date.now() - 86_400_000).toISOString(), place: "Ruang BK"}))
      .rejects.toMatchObject({code: "invalid-argument"});
    await proposeMeeting(school.bk, {schoolId, conversationId, at: besok, place: "Ruang BK"});
    expect((await conversationOf(schoolId, conversationId)).meeting).toMatchObject({place: "Ruang BK", status: "diusulkan"});

    await expect(respondMeeting(school.siswa2, {schoolId, conversationId, accept: true})).rejects.toMatchObject({code: "not-found"});
    await respondMeeting(school.siswa, {schoolId, conversationId, accept: true});
    expect((await conversationOf(schoolId, conversationId)).meeting).toMatchObject({status: "disetujui"});

    await expect(closeConversation(school.bk2, {schoolId, conversationId})).rejects.toMatchObject({code: "not-found"});
    await closeConversation(school.siswa, {schoolId, conversationId});
    expect(await conversationOf(schoolId, conversationId)).toMatchObject({status: "selesai"});
    await expect(closeConversation(school.bk, {schoolId, conversationId})).rejects.toMatchObject({code: "failed-precondition"});
    expect((await messagesOf(schoolId, conversationId)).at(-1)).toMatchObject({senderRole: "sistem"});
  });
});
