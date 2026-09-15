import {SUPERADMIN, asCaller, db, resetEmulators} from "./helpers";
import {beforeEach, describe, expect, it} from "vitest";
import {lookupSchool} from "../src/schools/lookup";
import {changeSchoolCode, createSchool, updateSchool} from "../src/schools/manage";

const baseSchool = {name: "SMA Negeri 1 Contoh", level: "SMA", city: "Lamongan", province: "Jawa Timur"};

describe("sekolah", () => {
  beforeEach(resetEmulators);

  it("superadmin membuat sekolah dengan unit bawaan dan kode unik", async () => {
    const {schoolId, code} = await createSchool(SUPERADMIN, {...baseSchool, code: "smansa1"});
    expect(code).toBe("SMANSA1");
    expect(schoolId).toMatch(/^sma-negeri-1-contoh-[a-z2-9]{4}$/);

    const units = await db.collection(`schools/${schoolId}/units`).get();
    expect(units.docs.map((doc) => doc.id).sort()).toEqual(["bk_ppks", "kesiswaan", "kurikulum", "manajemen", "sarpras", "tata_usaha"]);
    expect((await db.doc("schoolCodes/SMANSA1").get()).get("schoolId")).toBe(schoolId);

    await expect(createSchool(SUPERADMIN, {...baseSchool, name: "Sekolah Lain", code: "SMANSA1"}))
      .rejects.toMatchObject({code: "already-exists"});
  });

  it("lookup hanya menampilkan sekolah aktif", async () => {
    const {schoolId, code} = await createSchool(SUPERADMIN, baseSchool);
    await expect(lookupSchool({code: code.toLowerCase()})).resolves.toMatchObject({schoolId, name: baseSchool.name});

    await updateSchool(SUPERADMIN, {schoolId, active: false});
    await expect(lookupSchool({code})).rejects.toMatchObject({code: "not-found"});
  });

  it("admin sekolah mengubah pengaturan tetapi tidak bisa menonaktifkan sekolah", async () => {
    const {schoolId} = await createSchool(SUPERADMIN, baseSchool);
    const admin = asCaller("admin-1", {sid: schoolId, role: "admin", canVerify: true});

    await updateSchool(admin, {schoolId, allowedDomains: ["SMANSA.SCH.ID"], publicAspiration: false});
    expect((await db.doc(`schools/${schoolId}`).get()).data()).toMatchObject({
      allowedDomains: ["smansa.sch.id"],
      publicAspiration: false,
    });

    await expect(updateSchool(admin, {schoolId, allowedDomains: ["gmail.com"]})).rejects.toMatchObject({code: "invalid-argument"});
    await expect(updateSchool(admin, {schoolId, active: false})).rejects.toMatchObject({code: "permission-denied"});
    const otherAdmin = asCaller("admin-2", {sid: "sekolah-lain", role: "admin"});
    await expect(updateSchool(otherAdmin, {schoolId, city: "Tuban"})).rejects.toMatchObject({code: "permission-denied"});
  });

  it("mengganti kode sekolah menonaktifkan kode lama", async () => {
    const {schoolId, code} = await createSchool(SUPERADMIN, baseSchool);
    const {code: newCode} = await changeSchoolCode(SUPERADMIN, {schoolId});

    expect(newCode).not.toBe(code);
    await expect(lookupSchool({code})).rejects.toMatchObject({code: "not-found"});
    await expect(lookupSchool({code: newCode})).resolves.toMatchObject({schoolId});
  });
});
