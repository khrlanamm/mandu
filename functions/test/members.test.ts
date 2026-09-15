import {SUPERADMIN, asCaller, auth, createUser, db, freshCaller, resetEmulators} from "./helpers";
import {beforeEach, describe, expect, it} from "vitest";
import {acceptConsent, changeInitialPassword} from "../src/accounts/profile";
import {syncAccount} from "../src/accounts/sync";
import {CONSENT_VERSION} from "../src/domain/catalog";
import {inviteStaff} from "../src/members/invite";
import {cancelJoin, joinSchool} from "../src/members/join";
import {removeMember, updateMember} from "../src/members/manage";
import {reviewMembers} from "../src/members/review";
import {importStudents, resetStudentPassword} from "../src/members/students";
import {createSchool, updateSchool} from "../src/schools/manage";

async function setupSchool() {
  const school = await createSchool(SUPERADMIN, {
    name: "SMA Negeri 1 Contoh",
    level: "SMA",
    city: "Lamongan",
    province: "Jawa Timur",
    code: "CONTOH1",
  });
  await createUser("admin-1", "admin@sekolah.sch.id");
  await syncAccount(asCaller("admin-1"));
  const invite = await inviteStaff(SUPERADMIN, {schoolId: school.schoolId, email: "admin@sekolah.sch.id", role: "admin"});
  expect(invite.status).toBe("activated");
  return {...school, admin: await freshCaller("admin-1")};
}

async function newGoogleUser(uid: string, email: string, emailVerified = true) {
  await createUser(uid, email, {emailVerified});
  await syncAccount(asCaller(uid));
  return asCaller(uid);
}

describe("akun & keanggotaan sekolah", () => {
  beforeEach(resetEmulators);

  it("akun lama tanpa profil dibuatkan profil dan menyetujui kebijakan privasi", async () => {
    await createUser("lama-1", "lama@gmail.com");
    const caller = asCaller("lama-1");

    expect(await syncAccount(caller)).toMatchObject({status: "none", schoolId: null, needsConsent: true, isSuperadmin: false});
    await expect(acceptConsent(caller, {version: "2020-01"})).rejects.toMatchObject({code: "failed-precondition"});
    await acceptConsent(caller, {version: CONSENT_VERSION});
    expect(await syncAccount(caller)).toMatchObject({needsConsent: false});
  });

  it("siswa bergabung dengan kode, lalu disetujui admin dan mendapat claims", async () => {
    const {schoolId, admin} = await setupSchool();
    const student = await newGoogleUser("siswa-1", "siswa1@gmail.com");

    const joined = await joinSchool(student, {code: "contoh1", displayName: "Budi Santoso", kelas: "XI IPA 2"});
    expect(joined).toMatchObject({status: "pending", schoolId});
    await expect(joinSchool(student, {code: "CONTOH1", displayName: "Budi", kelas: "XI"}))
      .rejects.toMatchObject({code: "failed-precondition"});
    expect((await auth.getUser("siswa-1")).customClaims ?? {}).toEqual({});

    const review = await reviewMembers(admin, {schoolId, uids: ["siswa-1", "tidak-ada"], approve: true});
    expect(review).toEqual({updated: ["siswa-1"], skipped: ["tidak-ada"]});
    expect((await auth.getUser("siswa-1")).customClaims).toEqual({sid: schoolId, role: "siswa"});

    const user = (await db.doc("users/siswa-1").get()).data();
    expect(user).toMatchObject({status: "active", role: "siswa", schoolName: "SMA Negeri 1 Contoh", displayName: "Budi Santoso"});
    expect(user?.claimsVersion).toBeGreaterThan(0);
  });

  it("email domain sekolah langsung disetujui; NISN ganda ditolak", async () => {
    const {schoolId, admin} = await setupSchool();
    await updateSchool(admin, {schoolId, allowedDomains: ["sekolah.sch.id"]});

    const verified = await newGoogleUser("siswa-2", "siswa2@sekolah.sch.id");
    await expect(joinSchool(verified, {code: "CONTOH1", displayName: "Sari", kelas: "X-1", nisn: "0051234567"}))
      .resolves.toMatchObject({status: "active"});
    expect((await auth.getUser("siswa-2")).customClaims).toMatchObject({sid: schoolId, role: "siswa"});

    const unverified = await newGoogleUser("siswa-3", "siswa3@sekolah.sch.id", false);
    await expect(joinSchool(unverified, {code: "CONTOH1", displayName: "Rina", kelas: "X-1", nisn: "0051234567"}))
      .rejects.toMatchObject({code: "already-exists"});
    await expect(joinSchool(unverified, {code: "CONTOH1", displayName: "Rina", kelas: "X-1"}))
      .resolves.toMatchObject({status: "pending"});
  });

  it("hanya admin yang meninjau; siswa yang ditolak bisa mengajukan ulang atau membatalkan", async () => {
    const {schoolId, admin} = await setupSchool();
    const student = await newGoogleUser("siswa-4", "siswa4@gmail.com");
    await joinSchool(student, {code: "CONTOH1", displayName: "Andi", kelas: "XII"});

    const counselor = asCaller("bk-x", {sid: schoolId, role: "konselor"});
    await expect(reviewMembers(counselor, {schoolId, uids: ["siswa-4"], approve: true}))
      .rejects.toMatchObject({code: "permission-denied"});

    await reviewMembers(admin, {schoolId, uids: ["siswa-4"], approve: false});
    expect((await db.doc(`schools/${schoolId}/members/siswa-4`).get()).get("rejectionReason")).toBeTruthy();

    await expect(joinSchool(student, {code: "CONTOH1", displayName: "Andi", kelas: "XII"})).resolves.toMatchObject({status: "pending"});
    await cancelJoin(student);
    expect((await db.doc("users/siswa-4").get()).get("status")).toBe("none");
  });

  it("undangan staf aktif saat pengguna masuk; admin terakhir tidak bisa diturunkan", async () => {
    const {schoolId, admin} = await setupSchool();
    const invited = await inviteStaff(admin, {schoolId, email: "BK@Sekolah.sch.id", role: "konselor", units: ["bk_ppks"], canVerify: true});
    expect(invited.status).toBe("invited");

    await createUser("guru-bk", "bk@sekolah.sch.id");
    expect(await syncAccount(asCaller("guru-bk"))).toMatchObject({status: "active", role: "konselor", schoolId, claimsUpdated: true});
    expect((await auth.getUser("guru-bk")).customClaims).toEqual({sid: schoolId, role: "konselor", units: ["bk_ppks"], canVerify: true});

    await expect(updateMember(admin, {schoolId, uid: "admin-1", role: "pimpinan"})).rejects.toMatchObject({code: "failed-precondition"});
    await expect(updateMember(admin, {schoolId, uid: "guru-bk", units: ["unit-palsu"]})).rejects.toMatchObject({code: "invalid-argument"});

    await updateMember(admin, {schoolId, uid: "guru-bk", role: "petugas", units: ["sarpras"], canVerify: false});
    expect((await auth.getUser("guru-bk")).customClaims).toEqual({sid: schoolId, role: "petugas", units: ["sarpras"]});
  });

  it("admin membuatkan akun untuk staf tanpa Google", async () => {
    const {schoolId, admin} = await setupSchool();
    const result = await inviteStaff(admin, {
      schoolId,
      email: "tu@sekolah.sch.id",
      displayName: "Staf TU",
      role: "petugas",
      units: ["tata_usaha"],
      createAccount: true,
    });

    expect(result.status).toBe("activated");
    expect(result.passwordSetupLink).toContain("oobCode");
    expect((await auth.getUserByEmail("tu@sekolah.sch.id")).customClaims).toEqual({sid: schoolId, role: "petugas", units: ["tata_usaha"]});
  });

  it("impor akun NISN, ganti password awal, reset, lalu keluarkan", async () => {
    const {schoolId, admin} = await setupSchool();
    const imported = await importStudents(admin, {
      schoolId,
      students: [
        {nisn: "0061111111", name: "Dewi Lestari", kelas: "X-2"},
        {nisn: "0062222222", name: "Eko Prasetyo", kelas: "X-2"},
        {nisn: "0061111111", name: "Dewi Ganda", kelas: "X-3"},
      ],
    });
    expect(imported.created).toBe(2);
    expect(imported.results.map((row) => row.status)).toEqual(["created", "created", "duplicate"]);
    expect(imported.results[0].password).toMatch(/^[a-z2-9]{10}$/);

    const again = await importStudents(admin, {schoolId, students: [{nisn: "0062222222", name: "Eko", kelas: "X-2"}]});
    expect(again.results[0].status).toBe("duplicate");

    const dewi = await auth.getUserByEmail(`${schoolId}.0061111111@nisn.teman-ngadu.web.app`);
    expect(dewi.customClaims).toEqual({sid: schoolId, role: "siswa"});
    const dewiCaller = await freshCaller(dewi.uid);
    expect(await syncAccount(dewiCaller)).toMatchObject({status: "active", mustChangePassword: true, claimsUpdated: false});

    await expect(changeInitialPassword(dewiCaller, {newPassword: "abc0061111111"})).rejects.toMatchObject({code: "invalid-argument"});
    await changeInitialPassword(dewiCaller, {newPassword: "PasswordBaru#1"});
    expect((await db.doc(`users/${dewi.uid}`).get()).get("mustChangePassword")).toBe(false);

    const {password} = await resetStudentPassword(admin, {schoolId, uid: dewi.uid});
    expect(password).toMatch(/^[a-z2-9]{10}$/);
    expect((await db.doc(`users/${dewi.uid}`).get()).get("mustChangePassword")).toBe(true);

    await removeMember(admin, {schoolId, uid: dewi.uid});
    const removed = await auth.getUser(dewi.uid);
    expect(removed.disabled).toBe(true);
    expect(removed.customClaims ?? {}).toEqual({});
    expect((await db.doc(`users/${dewi.uid}`).get()).data()).toMatchObject({status: "removed", schoolId: null});
  });
});
