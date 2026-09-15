import {SUPERADMIN, addMember, db, resetEmulators} from "./helpers";
import {Timestamp} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {beforeEach, describe, expect, it} from "vitest";
import {createSchool, updateSchool} from "../src/schools/manage";
import {runSlaReminders} from "../src/tickets/reminders";
import {submitTicket} from "../src/tickets/submit";
import {
  addTicketProgress,
  cancelTicket,
  rateTicket,
  reassignTicket,
  resolveTicket,
  supplyTicketInfo,
  verifyTicket,
} from "../src/tickets/workflow";

async function setupSchool() {
  const {schoolId} = await createSchool(SUPERADMIN, {
    name: "SMA Uji Laporan",
    level: "SMA",
    city: "Lamongan",
    province: "Jawa Timur",
    code: "LAPOR1",
  });
  return {
    schoolId,
    admin: await addMember(schoolId, "admin", {displayName: "Andi Admin", role: "admin"}),
    bk: await addMember(schoolId, "bk", {displayName: "Sri BK", role: "konselor", units: ["bk_ppks"], canVerify: true}),
    sarpras: await addMember(schoolId, "sarpras", {displayName: "Joko Sarpras", role: "petugas", units: ["sarpras"]}),
    kurikulum: await addMember(schoolId, "kurikulum", {displayName: "Ratna Kurikulum", role: "petugas", units: ["kurikulum"]}),
    kepsek: await addMember(schoolId, "kepsek", {displayName: "Pak Kepsek", role: "pimpinan"}),
    siswa: await addMember(schoolId, "siswa", {displayName: "Budi Santoso", role: "siswa", kelas: "XI IPA 1"}),
    siswa2: await addMember(schoolId, "siswa2", {displayName: "Siti Aminah", role: "siswa", kelas: "X-2"}),
  };
}

type School = Awaited<ReturnType<typeof setupSchool>>;

let sequence = 0;
const newTicketId = () => `tiket${Date.now()}x${sequence++}`.padEnd(20, "0");

const report = (school: School, overrides: Record<string, unknown> = {}) => ({
  schoolId: school.schoolId,
  ticketId: newTicketId(),
  category: "fasilitas",
  subcategory: "perabot",
  title: "Kursi kelas rusak",
  description: "Tiga kursi di kelas XI IPA 1 patah dan berbahaya.",
  location: "Kelas XI IPA 1",
  incidentDate: "2026-09-14",
  anonymous: false,
  attachments: [],
  ...overrides,
});

const notificationsOf = async (uid: string) =>
  (await db.collection(`users/${uid}/notifications`).get()).docs.map((doc) => doc.data());
const ticketOf = async (schoolId: string, ticketId: string) =>
  (await db.doc(`schools/${schoolId}/tickets/${ticketId}`).get()).data()!;
const timelineOf = async (schoolId: string, ticketId: string) =>
  (await db.collection(`schools/${schoolId}/tickets/${ticketId}/timeline`).orderBy("createdAt").get()).docs.map((doc) => doc.data());

describe("layanan Lapor", () => {
  beforeEach(resetEmulators);

  it("nomor tiket berurutan, identitas pelapor terpisah, verifikator dinotifikasi", async () => {
    const school = await setupSchool();
    const first = await submitTicket(school.siswa, report(school));
    const second = await submitTicket(school.siswa2, report(school, {anonymous: true, location: "Kantin"}));

    expect(first.number).toMatch(/^MND-\d{4}-0001$/);
    expect(second.number).toMatch(/^MND-\d{4}-0002$/);
    expect(await ticketOf(school.schoolId, first.ticketId)).toMatchObject({
      status: "menunggu_verifikasi",
      reporter: {name: "Budi Santoso", kelas: "XI IPA 1"},
      priority: "normal",
    });
    expect((await ticketOf(school.schoolId, second.ticketId)).reporter).toBeNull();
    expect((await db.doc(`schools/${school.schoolId}/ticketOwners/${second.ticketId}`).get()).get("uid")).toBe("siswa2");

    expect(await notificationsOf("admin")).toHaveLength(2);
    expect(await notificationsOf("bk")).toHaveLength(2);
    expect(await notificationsOf("sarpras")).toHaveLength(0);
  });

  it("laporan darurat memberi tahu konselor dan memakai batas verifikasi darurat", async () => {
    const school = await setupSchool();
    const result = await submitTicket(school.siswa, report(school, {
      category: "keamanan",
      subcategory: "perundungan",
      title: "Teman diancam",
      description: "Teman sekelas diancam dengan pisau sepulang sekolah",
      anonymous: true,
    }));

    expect(result.priority).toBe("darurat");
    const ticket = await ticketOf(school.schoolId, result.ticketId);
    const hours = (ticket.sla.verifyDueAt.toMillis() - ticket.createdAt.toMillis()) / 3_600_000;
    expect(hours).toBeCloseTo(2);
    expect((await notificationsOf("bk"))[0]).toMatchObject({urgent: true});
  });

  it("menolak pengirim bukan siswa, lampiran belum diunggah, dan layanan nonaktif", async () => {
    const school = await setupSchool();
    await expect(submitTicket(school.sarpras, report(school))).rejects.toMatchObject({code: "permission-denied"});

    const ticketId = newTicketId();
    const outside = {path: `schools/${school.schoolId}/tickets/lain/lampiran/a.jpg`, name: "a.jpg", contentType: "image/jpeg", size: 10};
    await expect(submitTicket(school.siswa, report(school, {ticketId, attachments: [outside]}))).rejects.toMatchObject({code: "invalid-argument"});

    const path = `schools/${school.schoolId}/tickets/${ticketId}/lampiran/foto.jpg`;
    const attachment = {path, name: "foto.jpg", contentType: "image/jpeg", size: 3};
    await expect(submitTicket(school.siswa, report(school, {ticketId, attachments: [attachment]}))).rejects.toMatchObject({code: "failed-precondition"});
    await getStorage().bucket().file(path).save(Buffer.from([1, 2, 3]), {contentType: "image/jpeg"});
    await expect(submitTicket(school.siswa, report(school, {ticketId, attachments: [attachment]}))).resolves.toMatchObject({ticketId});

    await updateSchool(SUPERADMIN, {
      schoolId: school.schoolId,
      services: {lapor: false, curhat: true, aspirasi: true, bantuan: true, edukasi: true},
    });
    await expect(submitTicket(school.siswa, report(school))).rejects.toMatchObject({code: "failed-precondition"});
  });

  it("alur lengkap: verifikasi, unit menangani, selesai, dinilai pelapor", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {ticketId} = await submitTicket(school.siswa, report(school));

    await expect(verifyTicket(school.sarpras, {schoolId, ticketId, decision: "forward"})).rejects.toMatchObject({code: "permission-denied"});
    await expect(verifyTicket(school.bk, {schoolId, ticketId, decision: "forward"}))
      .resolves.toEqual({status: "diteruskan", unitName: "Sarana & Prasarana"});
    expect(await notificationsOf("sarpras")).toHaveLength(1);
    expect((await notificationsOf("siswa")).map((notification) => notification.route)).toContain(`/home/laporan/${ticketId}`);

    await expect(addTicketProgress(school.kurikulum, {schoolId, ticketId, message: "Saya bantu cek"}))
      .rejects.toMatchObject({code: "permission-denied"});
    await expect(addTicketProgress(school.sarpras, {schoolId, ticketId, message: "Kursi sedang diperbaiki tukang."}))
      .resolves.toEqual({status: "diproses"});
    await addTicketProgress(school.sarpras, {schoolId, ticketId, message: "Anggaran dari dana BOS.", visibility: "internal"});
    await expect(resolveTicket(school.kepsek, {schoolId, ticketId, note: "Sudah beres semuanya."}))
      .rejects.toMatchObject({code: "permission-denied"});
    await resolveTicket(school.sarpras, {schoolId, ticketId, note: "Tiga kursi sudah diganti yang baru."});

    await expect(rateTicket(school.siswa2, {schoolId, ticketId, score: 1})).rejects.toMatchObject({code: "not-found"});
    await rateTicket(school.siswa, {schoolId, ticketId, score: 5, comment: "Cepat sekali"});
    await expect(rateTicket(school.siswa, {schoolId, ticketId, score: 4})).rejects.toMatchObject({code: "failed-precondition"});

    expect(await ticketOf(schoolId, ticketId)).toMatchObject({
      status: "selesai",
      unitId: "sarpras",
      rating: {score: 5},
      resolution: {resolvedByName: "Joko Sarpras"},
    });
    const timeline = await timelineOf(schoolId, ticketId);
    expect(timeline.map((event) => event.type)).toEqual(["dibuat", "diteruskan", "progres", "catatan_internal", "selesai", "dinilai"]);
    expect(timeline.find((event) => event.type === "catatan_internal")?.visibility).toBe("internal");
  });

  it("minta data, pelapor melengkapi, lalu ditolak; pembatalan hanya sebelum diteruskan", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {ticketId} = await submitTicket(school.siswa, report(school));

    await verifyTicket(school.admin, {schoolId, ticketId, decision: "request_info", message: "Mohon lampirkan foto kursi."});
    expect((await ticketOf(schoolId, ticketId)).status).toBe("perlu_dilengkapi");
    await expect(supplyTicketInfo(school.siswa2, {schoolId, ticketId, message: "bukan punya saya"})).rejects.toMatchObject({code: "not-found"});
    await supplyTicketInfo(school.siswa, {schoolId, ticketId, message: "Kursinya ada di baris belakang."});
    expect(await ticketOf(schoolId, ticketId)).toMatchObject({status: "menunggu_verifikasi", infoRequest: null});

    await verifyTicket(school.admin, {schoolId, ticketId, decision: "reject", reason: "duplikat"});
    expect(await ticketOf(schoolId, ticketId)).toMatchObject({status: "ditolak", rejection: {reason: "duplikat"}});
    await expect(cancelTicket(school.siswa, {schoolId, ticketId})).rejects.toMatchObject({code: "failed-precondition"});

    const other = await submitTicket(school.siswa, report(school, {location: "Lab Kimia"}));
    await cancelTicket(school.siswa, {schoolId, ticketId: other.ticketId});
    expect((await ticketOf(schoolId, other.ticketId)).status).toBe("dibatalkan");
  });

  it("mendeteksi kemungkinan duplikat dan mengalihkan unit", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const first = await submitTicket(school.siswa, report(school));
    const second = await submitTicket(school.siswa2, report(school, {location: "  kelas xi ipa 1 "}));
    expect((await ticketOf(schoolId, second.ticketId)).possibleDuplicateOf).toBe(first.ticketId);

    await verifyTicket(school.admin, {schoolId, ticketId: first.ticketId, decision: "forward"});
    await expect(reassignTicket(school.sarpras, {schoolId, ticketId: first.ticketId, unitId: "kurikulum"}))
      .rejects.toMatchObject({code: "permission-denied"});
    await reassignTicket(school.admin, {schoolId, ticketId: first.ticketId, unitId: "kurikulum"});
    expect(await ticketOf(schoolId, first.ticketId)).toMatchObject({unitId: "kurikulum", status: "diteruskan"});
    await expect(addTicketProgress(school.kurikulum, {schoolId, ticketId: first.ticketId, message: "Diterima unit kurikulum."}))
      .resolves.toEqual({status: "diproses"});
  });

  it("pengingat SLA dikirim sekali untuk laporan yang terlambat", async () => {
    const school = await setupSchool();
    const {ticketId} = await submitTicket(school.siswa, report(school));
    await db.doc(`schools/${school.schoolId}/tickets/${ticketId}`).update({"sla.verifyDueAt": Timestamp.fromMillis(Date.now() - 60_000)});
    const before = (await notificationsOf("admin")).length;

    expect(await runSlaReminders()).toEqual({verify: 1, resolve: 0});
    expect(await runSlaReminders()).toEqual({verify: 0, resolve: 0});
    expect(await notificationsOf("admin")).toHaveLength(before + 1);
  });
});
