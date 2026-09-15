import {Timestamp} from "firebase-admin/firestore";
import {beforeEach, describe, expect, it} from "vitest";
import {submitAspiration} from "../src/aspirations/submit";
import {requestHelp} from "../src/care/help";
import {createSchool} from "../src/schools/manage";
import {platformStats, schoolStats} from "../src/stats/compute";
import {submitTicket} from "../src/tickets/submit";
import {addTicketProgress, rateTicket, resolveTicket, verifyTicket} from "../src/tickets/workflow";
import {SUPERADMIN, addMember, db, resetEmulators} from "./helpers";

let sequence = 0;
const newTicketId = () => `stat${Date.now()}x${sequence++}`.padEnd(20, "0");

async function setupSchool() {
  const {schoolId} = await createSchool(SUPERADMIN, {name: "SMA Statistik", level: "SMA", city: "Lamongan", province: "Jawa Timur", code: "STATIS"});
  return {
    schoolId,
    admin: await addMember(schoolId, "admin", {displayName: "Andi Admin", role: "admin"}),
    kepsek: await addMember(schoolId, "kepsek", {displayName: "Pak Kepsek", role: "pimpinan"}),
    sarpras: await addMember(schoolId, "sarpras", {displayName: "Joko Sarpras", role: "petugas", units: ["sarpras"]}),
    siswa: await addMember(schoolId, "siswa", {displayName: "Budi Santoso", role: "siswa", kelas: "XI IPA 1"}),
  };
}

const report = (schoolId: string, overrides: Record<string, unknown> = {}) => ({
  schoolId,
  ticketId: newTicketId(),
  category: "fasilitas",
  subcategory: "perabot",
  title: "Kursi kelas rusak",
  description: "Kursi di barisan belakang patah dan berbahaya.",
  location: "Kelas XI IPA 1",
  anonymous: false,
  attachments: [],
  ...overrides,
});

describe("statistik dashboard", () => {
  beforeEach(resetEmulators);

  it("merangkum laporan, unit, aspirasi, bantuan, dan anggota", async () => {
    const school = await setupSchool();
    const {schoolId} = school;

    const done = await submitTicket(school.siswa, report(schoolId));
    await verifyTicket(school.admin, {schoolId, ticketId: done.ticketId, decision: "forward"});
    await addTicketProgress(school.sarpras, {schoolId, ticketId: done.ticketId, message: "Sedang diperbaiki tukang."});
    await resolveTicket(school.sarpras, {schoolId, ticketId: done.ticketId, note: "Kursi sudah diganti semua."});
    await rateTicket(school.siswa, {schoolId, ticketId: done.ticketId, score: 4});

    const waiting = await submitTicket(school.siswa, report(schoolId, {category: "kebersihan", subcategory: "toilet", location: "Toilet lantai 2"}));
    await db.doc(`schools/${schoolId}/tickets/${waiting.ticketId}`)
      .update({"sla.verifyDueAt": Timestamp.fromMillis(Date.now() - 3_600_000)});

    await submitAspiration(school.siswa, {
      schoolId,
      anonymous: false,
      type: "usulan",
      topic: "kantin",
      title: "Tambah menu sehat",
      content: "Usul kantin menyediakan buah setiap hari agar siswa lebih sehat.",
    });
    await requestHelp(school.siswa, {
      schoolId,
      needs: ["ingin_bicara"],
      urgency: "biasa",
      contactMethod: "bertemu",
      contactTime: "istirahat",
    });

    const stats = await schoolStats(school.admin, {schoolId});
    expect(stats.tickets).toMatchObject({total: 2, overdue: 1, ratingCount: 1, avgRating: 4});
    expect(stats.tickets.byStatus).toMatchObject({selesai: 1, menunggu_verifikasi: 1});
    expect(stats.tickets.byCategory).toMatchObject({fasilitas: 1, kebersihan: 1});
    expect(stats.tickets.avgResolveHours).not.toBeNull();
    expect(stats.tickets.monthly).toHaveLength(6);
    expect(stats.tickets.monthly.at(-1)).toMatchObject({total: 2, selesai: 1});
    expect(stats.tickets.topLocations[0]).toMatchObject({location: "Kelas XI IPA 1", count: 1});

    const sarpras = stats.tickets.units.find((unit) => unit.unitId === "sarpras")!;
    expect(sarpras).toMatchObject({total: 1, selesai: 1, onTimePercent: 100});
    expect(stats.aspirations).toMatchObject({total: 1, published: 0});
    expect(stats.care).toMatchObject({helpTotal: 1, conversations: 0});
    expect(stats.members).toMatchObject({total: 4, byRole: {admin: 1, siswa: 1, petugas: 1, pimpinan: 1}});
  });

  it("dashboard hanya untuk admin, pimpinan, Tim Verifikasi, dan superadmin", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    await expect(schoolStats(school.kepsek, {schoolId})).resolves.toBeTruthy();
    await expect(schoolStats(SUPERADMIN, {schoolId})).resolves.toBeTruthy();
    await expect(schoolStats(school.sarpras, {schoolId})).rejects.toMatchObject({code: "permission-denied"});
    await expect(schoolStats(school.siswa, {schoolId})).rejects.toMatchObject({code: "permission-denied"});
    await expect(platformStats(school.admin)).rejects.toMatchObject({code: "permission-denied"});
  });

  it("statistik platform merangkum semua sekolah untuk superadmin", async () => {
    const school = await setupSchool();
    await submitTicket(school.siswa, report(school.schoolId));
    await createSchool(SUPERADMIN, {name: "SMP Kedua", level: "SMP", city: "Tuban", province: "Jawa Timur", code: "KEDUA1"});

    const stats = await platformStats(SUPERADMIN);
    expect(stats.totals).toMatchObject({schools: 2, activeSchools: 2, tickets: 1});
    expect(stats.schools[0]).toMatchObject({name: "SMA Statistik", tickets: 1, open: 1, members: 4});
  });
});
