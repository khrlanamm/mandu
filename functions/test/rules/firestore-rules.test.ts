import {readFileSync} from "node:fs";
import {resolve} from "node:path";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
  type RulesTestEnvironment,
} from "@firebase/rules-unit-testing";
import {
  collection,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  orderBy,
  query,
  serverTimestamp,
  setDoc,
  Timestamp,
  updateDoc,
  where,
} from "firebase/firestore";
import {afterAll, beforeAll, beforeEach, describe, it} from "vitest";

let env: RulesTestEnvironment;

const firestoreAs = (uid: string, claims: Record<string, unknown> = {}) => env.authenticatedContext(uid, claims).firestore();
const guest = () => env.unauthenticatedContext().firestore();

const adminA = () => firestoreAs("admin-a", {sid: "sekolah-a", role: "admin", canVerify: true});
const siswaA = () => firestoreAs("siswa-a", {sid: "sekolah-a", role: "siswa"});

const legacyReport = (userId: string, status: string, extra: Record<string, unknown> = {}) => ({
  id: "x",
  userId,
  peran: "Korban",
  tanggalBullying: "01/09/2026",
  lokasi: "Kelas",
  frekuensi: "Sering",
  deskripsi: "Kronologi",
  nomorWhatsapp: "081234567890",
  urlBukti: null,
  timestamp: Timestamp.now(),
  status,
  ...extra,
});

beforeAll(async () => {
  env = await initializeTestEnvironment({
    projectId: "demo-mandu",
    firestore: {rules: readFileSync(resolve(process.cwd(), "../firestore.rules"), "utf8")},
  });
});

afterAll(async () => {
  await env?.cleanup();
});

beforeEach(async () => {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await Promise.all([
      setDoc(doc(db, "platform/config"), {emergencyContacts: []}),
      setDoc(doc(db, "users/siswa-a"), {uid: "siswa-a", status: "active"}),
      setDoc(doc(db, "schoolCodes/SEKOLAHA"), {schoolId: "sekolah-a"}),
      setDoc(doc(db, "schools/sekolah-a"), {name: "Sekolah A"}),
      setDoc(doc(db, "schools/sekolah-a/members/siswa-a"), {role: "siswa", status: "active"}),
      setDoc(doc(db, "schools/sekolah-a/members/calon-a"), {role: "siswa", status: "pending"}),
      setDoc(doc(db, "schools/sekolah-a/units/sarpras"), {name: "Sarana & Prasarana"}),
      setDoc(doc(db, "schools/sekolah-b"), {name: "Sekolah B"}),
      setDoc(doc(db, "invitations/inv-a"), {schoolId: "sekolah-a", email: "bk@a.sch.id", status: "pending"}),
      setDoc(doc(db, "admins/admin-lama"), {fcmToken: "lama"}),
      setDoc(doc(db, "reports/alice1"), legacyReport("alice", "terlapor")),
      setDoc(doc(db, "reports/alice2"), legacyReport("alice", "ditangani")),
      setDoc(doc(db, "reports/bob1"), legacyReport("bob", "terlapor")),
      // Migrasi tahap 7 menambahkan `published` pada 50 artikel lama; tanpa field itu artikel tidak terbaca.
      setDoc(doc(db, "articles/a1"), {id: 1, title: "Artikel", published: true}),
      setDoc(doc(db, "articles/belum-migrasi"), {id: 2, title: "Artikel lama"}),
    ]);
  });
});

describe("rules MANDU 2.0", () => {
  it("profil hanya dibaca pemiliknya dan tidak bisa ditulis aplikasi", async () => {
    await assertSucceeds(getDoc(doc(siswaA(), "users/siswa-a")));
    await assertFails(getDoc(doc(firestoreAs("siswa-b"), "users/siswa-a")));
    await assertFails(setDoc(doc(siswaA(), "users/siswa-a"), {isSuperadmin: true}));
  });

  it("data sekolah hanya untuk anggota aktif sekolah itu dan superadmin", async () => {
    await assertSucceeds(getDoc(doc(siswaA(), "schools/sekolah-a")));
    await assertSucceeds(getDocs(collection(siswaA(), "schools/sekolah-a/units")));
    await assertFails(getDoc(doc(siswaA(), "schools/sekolah-b")));
    await assertFails(getDoc(doc(firestoreAs("calon-a"), "schools/sekolah-a")));
    await assertFails(getDoc(doc(guest(), "schools/sekolah-a")));
    await assertSucceeds(getDoc(doc(firestoreAs("superadmin", {sa: true}), "schools/sekolah-b")));
    await assertFails(setDoc(doc(adminA(), "schools/sekolah-a"), {name: "Diganti"}));
  });

  it("keanggotaan dibaca pemiliknya (termasuk yang menunggu), admin, dan pimpinan", async () => {
    await assertSucceeds(getDoc(doc(firestoreAs("calon-a"), "schools/sekolah-a/members/calon-a")));
    await assertFails(getDoc(doc(firestoreAs("calon-a"), "schools/sekolah-a/members/siswa-a")));
    await assertSucceeds(getDocs(collection(adminA(), "schools/sekolah-a/members")));
    await assertSucceeds(getDocs(collection(firestoreAs("kepsek-a", {sid: "sekolah-a", role: "pimpinan"}), "schools/sekolah-a/members")));
    await assertFails(getDocs(collection(firestoreAs("bk-a", {sid: "sekolah-a", role: "konselor"}), "schools/sekolah-a/members")));
    await assertFails(getDocs(collection(siswaA(), "schools/sekolah-a/members")));
    await assertFails(getDocs(collection(firestoreAs("admin-b", {sid: "sekolah-b", role: "admin"}), "schools/sekolah-a/members")));
    await assertFails(updateDoc(doc(adminA(), "schools/sekolah-a/members/siswa-a"), {role: "admin"}));
  });

  it("undangan hanya untuk admin sekolahnya; kode sekolah tertutup; konfigurasi untuk yang login", async () => {
    await assertSucceeds(getDocs(query(collection(adminA(), "invitations"), where("schoolId", "==", "sekolah-a"))));
    await assertFails(getDocs(collection(adminA(), "invitations")));
    await assertFails(getDoc(doc(firestoreAs("admin-b", {sid: "sekolah-b", role: "admin"}), "invitations/inv-a")));
    await assertSucceeds(getDoc(doc(firestoreAs("superadmin", {sa: true}), "invitations/inv-a")));
    await assertFails(getDoc(doc(adminA(), "schoolCodes/SEKOLAHA")));
    await assertSucceeds(getDoc(doc(firestoreAs("tamu-anonim"), "platform/config")));
    await assertFails(getDoc(doc(guest(), "platform/config")));
  });
});

describe("rules aplikasi 4.0.0 (legacy)", () => {
  it("pengguna hanya melihat dan membatalkan laporannya sendiri", async () => {
    const alice = firestoreAs("alice");
    await assertSucceeds(getDocs(query(collection(alice, "reports"), where("userId", "==", "alice"), orderBy("timestamp", "desc"))));
    await assertFails(getDocs(query(collection(alice, "reports"), orderBy("timestamp", "desc"))));
    await assertFails(getDoc(doc(alice, "reports/bob1")));
    await assertSucceeds(deleteDoc(doc(alice, "reports/alice1")));
    await assertFails(deleteDoc(doc(alice, "reports/alice2")));
    await assertFails(updateDoc(doc(alice, "reports/bob1"), {status: "ditangani"}));
  });

  it("laporan baru harus valid dan atas nama pengirimnya", async () => {
    const alice = firestoreAs("alice");
    await assertSucceeds(setDoc(doc(alice, "reports/baru1"), legacyReport("alice", "terlapor", {timestamp: serverTimestamp()})));
    await assertFails(setDoc(doc(alice, "reports/baru2"), legacyReport("bob", "terlapor")));
    await assertFails(setDoc(doc(alice, "reports/baru3"), legacyReport("alice", "ditangani")));
    await assertFails(setDoc(doc(alice, "reports/baru4"), legacyReport("alice", "terlapor", {isAdmin: true})));
  });

  it("admin lama mengubah status laporan dan token FCM miliknya saja", async () => {
    const admin = firestoreAs("admin-lama");
    await assertSucceeds(getDocs(query(collection(admin, "reports"), orderBy("timestamp", "desc"))));
    await assertSucceeds(updateDoc(doc(admin, "reports/bob1"), {status: "ditangani"}));
    await assertFails(updateDoc(doc(admin, "reports/bob1"), {deskripsi: "diubah"}));
    await assertSucceeds(updateDoc(doc(admin, "admins/admin-lama"), {fcmToken: "baru"}));
    await assertFails(setDoc(doc(firestoreAs("alice"), "admins/alice"), {fcmToken: "x"}));
    await assertSucceeds(getDoc(doc(firestoreAs("alice"), "articles/a1")));
    await assertFails(getDoc(doc(guest(), "articles/a1")));
    await assertFails(getDoc(doc(firestoreAs("alice"), "articles/belum-migrasi")));
  });
});
