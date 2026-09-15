import {readFileSync} from "node:fs";
import {resolve} from "node:path";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
  type RulesTestEnvironment,
} from "@firebase/rules-unit-testing";
import {collection, doc, getDoc, getDocs, orderBy, query, setDoc, Timestamp, updateDoc, where} from "firebase/firestore";
import {getBytes, ref, uploadBytes} from "firebase/storage";
import {afterAll, beforeAll, beforeEach, describe, it} from "vitest";

const SCHOOL = "sekolah-a";
let env: RulesTestEnvironment;

const as = (uid: string, claims: Record<string, unknown> = {}) => env.authenticatedContext(uid, claims);
const siswa = () => as("siswa-a", {sid: SCHOOL, role: "siswa"});
const siswaLain = () => as("siswa-b", {sid: SCHOOL, role: "siswa"});
const admin = () => as("admin-a", {sid: SCHOOL, role: "admin", canVerify: true});
const kepsek = () => as("kepsek-a", {sid: SCHOOL, role: "pimpinan"});
const sarpras = () => as("sarpras-a", {sid: SCHOOL, role: "petugas", units: ["sarpras"]});
const kurikulum = () => as("kurikulum-a", {sid: SCHOOL, role: "petugas", units: ["kurikulum"]});
const bkVerifikator = () => as("bk-a", {sid: SCHOOL, role: "konselor", units: ["bk_ppks"], canVerify: true});
const superadmin = () => as("superadmin", {sa: true});

const ticketPath = (id: string) => `schools/${SCHOOL}/tickets/${id}`;
const image = new Uint8Array([0xff, 0xd8, 0xff]);

beforeAll(async () => {
  env = await initializeTestEnvironment({
    projectId: "demo-mandu",
    firestore: {rules: readFileSync(resolve(process.cwd(), "../firestore.rules"), "utf8")},
    storage: {rules: readFileSync(resolve(process.cwd(), "../storage.rules"), "utf8")},
  });
});

afterAll(async () => {
  await env?.cleanup();
});

beforeEach(async () => {
  await env.clearFirestore();
  await env.clearStorage();
  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    const now = Timestamp.now();
    await Promise.all([
      setDoc(doc(db, ticketPath("t1")), {unitId: "sarpras", status: "diproses", title: "Kursi rusak", createdAt: now}),
      setDoc(doc(db, ticketPath("t2")), {unitId: null, status: "menunggu_verifikasi", title: "Belum diverifikasi", createdAt: now}),
      setDoc(doc(db, ticketPath("t3")), {unitId: null, status: "perlu_dilengkapi", title: "Perlu data", createdAt: now}),
      setDoc(doc(db, `schools/${SCHOOL}/ticketOwners/t1`), {uid: "siswa-a", createdAt: now}),
      setDoc(doc(db, `schools/${SCHOOL}/ticketOwners/t2`), {uid: "siswa-a", createdAt: now}),
      setDoc(doc(db, `schools/${SCHOOL}/ticketOwners/t3`), {uid: "siswa-a", createdAt: now}),
      setDoc(doc(db, `${ticketPath("t1")}/timeline/publik`), {visibility: "public", createdAt: now}),
      setDoc(doc(db, `${ticketPath("t1")}/timeline/internal`), {visibility: "internal", createdAt: now}),
      setDoc(doc(db, "users/siswa-a/notifications/n1"), {title: "Laporan diperbarui", read: false, createdAt: now}),
      setDoc(doc(db, "users/siswa-a/devices/d1"), {token: "rahasia"}),
    ]);
    await uploadBytes(ref(context.storage(), `${ticketPath("t1")}/lampiran/foto.jpg`), image, {contentType: "image/jpeg"});
  });
});

describe("rules laporan (Firestore)", () => {
  it("pelapor membaca laporannya sendiri, bukan milik orang lain", async () => {
    await assertSucceeds(getDoc(doc(siswa().firestore(), ticketPath("t1"))));
    await assertFails(getDoc(doc(siswaLain().firestore(), ticketPath("t1"))));
    await assertSucceeds(getDocs(query(collection(siswa().firestore(), `schools/${SCHOOL}/ticketOwners`), where("uid", "==", "siswa-a"))));
    await assertFails(getDocs(query(collection(siswaLain().firestore(), `schools/${SCHOOL}/ticketOwners`), where("uid", "==", "siswa-a"))));
  });

  it("staf membaca sesuai peran dan unit; superadmin tidak membaca isi laporan", async () => {
    await assertSucceeds(getDoc(doc(admin().firestore(), ticketPath("t1"))));
    await assertSucceeds(getDoc(doc(kepsek().firestore(), ticketPath("t1"))));
    await assertSucceeds(getDoc(doc(sarpras().firestore(), ticketPath("t1"))));
    await assertFails(getDoc(doc(kurikulum().firestore(), ticketPath("t1"))));
    await assertFails(getDoc(doc(superadmin().firestore(), ticketPath("t1"))));

    const tickets = (context: ReturnType<typeof as>) => collection(context.firestore(), `schools/${SCHOOL}/tickets`);
    await assertSucceeds(getDocs(query(tickets(sarpras()), where("unitId", "in", ["sarpras"]))));
    await assertFails(getDocs(query(tickets(kurikulum()), orderBy("createdAt", "desc"))));
    await assertSucceeds(getDocs(query(tickets(bkVerifikator()), orderBy("createdAt", "desc"))));
  });

  it("pelapor hanya melihat riwayat publik; catatan internal untuk staf", async () => {
    const timeline = (context: ReturnType<typeof as>) => collection(context.firestore(), `${ticketPath("t1")}/timeline`);
    await assertSucceeds(getDocs(query(timeline(siswa()), where("visibility", "==", "public"))));
    await assertFails(getDocs(timeline(siswa())));
    await assertSucceeds(getDocs(timeline(sarpras())));
    await assertFails(getDocs(timeline(kurikulum())));
  });

  it("tidak ada penulisan langsung ke laporan", async () => {
    await assertFails(updateDoc(doc(siswa().firestore(), ticketPath("t2")), {status: "dibatalkan"}));
    await assertFails(setDoc(doc(admin().firestore(), ticketPath("baru")), {status: "selesai"}));
    await assertFails(setDoc(doc(siswa().firestore(), `schools/${SCHOOL}/ticketOwners/baru`), {uid: "siswa-a"}));
  });

  it("notifikasi hanya untuk pemiliknya dan hanya boleh ditandai dibaca", async () => {
    const own = doc(siswa().firestore(), "users/siswa-a/notifications/n1");
    await assertSucceeds(getDoc(own));
    await assertSucceeds(updateDoc(own, {read: true}));
    await assertFails(updateDoc(own, {title: "Diubah"}));
    await assertFails(getDoc(doc(siswaLain().firestore(), "users/siswa-a/notifications/n1")));
    await assertFails(getDoc(doc(siswa().firestore(), "users/siswa-a/devices/d1")));
  });
});

describe("rules lampiran (Storage)", () => {
  it("siswa mengunggah lampiran untuk laporan baru atau saat diminta melengkapi", async () => {
    await assertSucceeds(uploadBytes(ref(siswa().storage(), `${ticketPath("baru")}/lampiran/a.jpg`), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(siswa().storage(), `${ticketPath("baru")}/lampiran/a.html`), image, {contentType: "text/html"}));
    await assertFails(uploadBytes(ref(siswa().storage(), `${ticketPath("t1")}/lampiran/b.jpg`), image, {contentType: "image/jpeg"}));
    await assertSucceeds(uploadBytes(ref(siswa().storage(), `${ticketPath("t3")}/lampiran/c.jpg`), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(siswaLain().storage(), `${ticketPath("t3")}/lampiran/d.jpg`), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(siswa().storage(), `${ticketPath("t1")}/lampiran/foto.jpg`), image, {contentType: "image/jpeg"}));
  });

  it("lampiran hanya dibuka pelapor dan staf yang berwenang", async () => {
    const path = `${ticketPath("t1")}/lampiran/foto.jpg`;
    await assertSucceeds(getBytes(ref(siswa().storage(), path)));
    await assertFails(getBytes(ref(siswaLain().storage(), path)));
    await assertSucceeds(getBytes(ref(sarpras().storage(), path)));
    await assertSucceeds(getBytes(ref(bkVerifikator().storage(), path)));
    await assertFails(getBytes(ref(kurikulum().storage(), path)));
  });

  it("dokumentasi tindak lanjut diunggah admin atau unit penangan", async () => {
    const path = `${ticketPath("t1")}/tindak-lanjut/hasil.jpg`;
    await assertSucceeds(uploadBytes(ref(sarpras().storage(), path), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(kurikulum().storage(), `${ticketPath("t1")}/tindak-lanjut/lain.jpg`), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(siswa().storage(), `${ticketPath("t1")}/tindak-lanjut/siswa.jpg`), image, {contentType: "image/jpeg"}));
  });
});
