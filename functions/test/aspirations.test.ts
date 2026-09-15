import {beforeEach, describe, expect, it} from "vitest";
import {reviewAspiration, supportAspiration} from "../src/aspirations/review";
import {submitAspiration, submitPublicAspiration} from "../src/aspirations/submit";
import {createSchool, updateSchool} from "../src/schools/manage";
import {SUPERADMIN, addMember, asCaller, db, resetEmulators} from "./helpers";

const CODE = "ASPIR1";

async function setupSchool() {
  const {schoolId} = await createSchool(SUPERADMIN, {name: "SMA Aspirasi", level: "SMA", city: "Lamongan", province: "Jawa Timur", code: CODE});
  return {
    schoolId,
    admin: await addMember(schoolId, "admin", {displayName: "Andi Admin", role: "admin"}),
    kepsek: await addMember(schoolId, "kepsek", {displayName: "Pak Kepsek", role: "pimpinan"}),
    sarpras: await addMember(schoolId, "sarpras", {displayName: "Joko Sarpras", role: "petugas", units: ["sarpras"]}),
    siswa: await addMember(schoolId, "siswa", {displayName: "Budi Santoso", role: "siswa", kelas: "XI IPA 1"}),
    siswa2: await addMember(schoolId, "siswa2", {displayName: "Siti Aminah", role: "siswa", kelas: "X-2"}),
  };
}

const idea = (schoolId: string, overrides: Record<string, unknown> = {}) => ({
  schoolId,
  anonymous: false,
  type: "usulan",
  topic: "kantin",
  title: "Tambah menu sehat di kantin",
  content: "Usul kantin menyediakan buah dan sayur setiap hari dengan harga terjangkau.",
  ...overrides,
});

const guestIdea = {
  code: CODE,
  type: "kritik",
  topic: "layanan",
  title: "Pelayanan surat di TU lambat",
  content: "Petugasnya goblok, antre surat keterangan bisa sampai tiga hari.",
};

const notificationsOf = async (uid: string) => (await db.collection(`users/${uid}/notifications`).get()).docs.map((doc) => doc.data());
const aspirationOf = async (schoolId: string, id: string) => (await db.doc(`schools/${schoolId}/aspirations/${id}`).get()).data()!;

describe("layanan Aspirasi", () => {
  beforeEach(resetEmulators);

  it("siswa mengirim aspirasi; identitas disimpan terpisah dan bisa dirahasiakan", async () => {
    const school = await setupSchool();
    const named = await submitAspiration(school.siswa, idea(school.schoolId));
    const hidden = await submitAspiration(school.siswa2, idea(school.schoolId, {anonymous: true, topic: "fasilitas"}));

    expect(named.number).toMatch(/^ASP-\d{4}-0001$/);
    expect(hidden.number).toMatch(/^ASP-\d{4}-0002$/);
    const doc = await aspirationOf(school.schoolId, named.aspirationId);
    expect(doc).toMatchObject({status: "diterima", board: "none", source: "siswa", supportCount: 0, typeLabel: "Usulan"});
    expect(doc).not.toHaveProperty("author");
    expect((await db.doc(`schools/${school.schoolId}/aspirations/${named.aspirationId}/private/identity`).get()).data())
      .toEqual({name: "Budi Santoso", kelas: "XI IPA 1"});
    expect((await db.doc(`schools/${school.schoolId}/aspirations/${hidden.aspirationId}/private/identity`).get()).exists).toBe(false);
    expect((await db.doc(`schools/${school.schoolId}/aspirationOwners/${hidden.aspirationId}`).get()).get("uid")).toBe("siswa2");

    expect(await notificationsOf("admin")).toHaveLength(2);
    expect(await notificationsOf("kepsek")).toHaveLength(0);
    await expect(submitAspiration(school.sarpras, idea(school.schoolId))).rejects.toMatchObject({code: "permission-denied"});
  });

  it("tamu mengirim lewat kode sekolah: tanpa identitas, kata kasar disamarkan, dibatasi per perangkat", async () => {
    const school = await setupSchool();
    const guest = asCaller("anon-1");
    const result = await submitPublicAspiration(guest, guestIdea, "10.0.0.1");

    expect(result).toMatchObject({schoolName: "SMA Aspirasi", flagged: true});
    const docs = (await db.collection(`schools/${school.schoolId}/aspirations`).get()).docs.map((doc) => doc.data());
    expect(docs[0]).toMatchObject({source: "tamu", anonymous: true, flagged: true});
    expect(docs[0].content).toContain("g*****");
    expect((await db.collection(`schools/${school.schoolId}/aspirationOwners`).get()).size).toBe(0);

    await submitPublicAspiration(guest, guestIdea, "10.0.0.1");
    await submitPublicAspiration(guest, guestIdea, "10.0.0.1");
    await expect(submitPublicAspiration(guest, guestIdea, "10.0.0.1")).rejects.toMatchObject({code: "resource-exhausted"});

    for (let index = 0; index < 10; index++) await submitPublicAspiration(null, guestIdea, "10.0.0.2");
    await expect(submitPublicAspiration(null, guestIdea, "10.0.0.2")).rejects.toMatchObject({code: "resource-exhausted"});

    await expect(submitPublicAspiration(null, {...guestIdea, code: "TIDAKADA"}, "10.0.0.3")).rejects.toMatchObject({code: "not-found"});
    await updateSchool(SUPERADMIN, {schoolId: school.schoolId, publicAspiration: false});
    await expect(submitPublicAspiration(null, guestIdea, "10.0.0.3")).rejects.toMatchObject({code: "failed-precondition"});
  });

  it("admin menanggapi dan menampilkan di papan; siswa mendukung sekali", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const {aspirationId} = await submitAspiration(school.siswa, idea(schoolId));

    await expect(reviewAspiration(school.kepsek, {schoolId, aspirationId, status: "ditinjau"})).rejects.toMatchObject({code: "permission-denied"});
    await expect(reviewAspiration(school.admin, {schoolId, aspirationId, response: "Terima kasih, akan dibahas bersama OSIS."}))
      .resolves.toEqual({status: "ditinjau", board: "none"});
    const [notification] = await notificationsOf("siswa");
    expect(notification).toMatchObject({type: "aspirasi_ditanggapi", route: `/home/aspirasi/${aspirationId}`});

    await expect(supportAspiration(school.siswa2, {schoolId, aspirationId, support: true})).rejects.toMatchObject({code: "not-found"});
    await reviewAspiration(school.admin, {schoolId, aspirationId, status: "ditindaklanjuti", board: "published"});
    expect(await aspirationOf(schoolId, aspirationId)).toMatchObject({
      status: "ditindaklanjuti",
      board: "published",
      response: {message: "Terima kasih, akan dibahas bersama OSIS.", respondedByName: "Andi Admin"},
    });

    expect(await supportAspiration(school.siswa2, {schoolId, aspirationId, support: true})).toEqual({supported: true, supportCount: 1});
    expect(await supportAspiration(school.siswa2, {schoolId, aspirationId, support: true})).toEqual({supported: true, supportCount: 1});
    expect(await supportAspiration(school.siswa, {schoolId, aspirationId, support: true})).toEqual({supported: true, supportCount: 2});
    expect(await supportAspiration(school.siswa2, {schoolId, aspirationId, support: false})).toEqual({supported: false, supportCount: 1});
    await expect(supportAspiration(school.admin, {schoolId, aspirationId, support: true})).rejects.toMatchObject({code: "permission-denied"});
  });
});
