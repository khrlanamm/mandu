import {readFileSync} from "node:fs";
import {resolve} from "node:path";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
  type RulesTestEnvironment,
} from "@firebase/rules-unit-testing";
import {collection, doc, getDoc, getDocs, query, setDoc, Timestamp, where} from "firebase/firestore";
import {afterAll, beforeAll, beforeEach, describe, it} from "vitest";

const SCHOOL = "sekolah-a";
const base = `schools/${SCHOOL}`;
let env: RulesTestEnvironment;

const as = (uid: string, claims: Record<string, unknown> = {}) => env.authenticatedContext(uid, claims).firestore();
const siswa = () => as("siswa-a", {sid: SCHOOL, role: "siswa"});
const siswaLain = () => as("siswa-b", {sid: SCHOOL, role: "siswa"});
const siswaSekolahLain = () => as("siswa-z", {sid: "sekolah-b", role: "siswa"});
const admin = () => as("admin-a", {sid: SCHOOL, role: "admin", canVerify: true});
const kepsek = () => as("kepsek-a", {sid: SCHOOL, role: "pimpinan"});
const sarpras = () => as("sarpras-a", {sid: SCHOOL, role: "petugas", units: ["sarpras"]});

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
    const now = Timestamp.now();
    await Promise.all([
      setDoc(doc(db, `${base}/aspirations/papan`), {board: "published", title: "Tambah loker", supportCount: 3, publishedAt: now}),
      setDoc(doc(db, `${base}/aspirations/baru`), {board: "none", title: "Jadwal ekskul", supportCount: 0, publishedAt: null}),
      setDoc(doc(db, `${base}/aspirations/baru/private/identity`), {name: "Budi", kelas: "X-1"}),
      setDoc(doc(db, `${base}/aspirationOwners/baru`), {uid: "siswa-a", createdAt: now}),
      setDoc(doc(db, `${base}/aspirations/papan/supports/siswa-a`), {createdAt: now}),
    ]);
  });
});

describe("rules aspirasi", () => {
  it("siswa membaca papan dan aspirasinya sendiri saja", async () => {
    await assertSucceeds(getDoc(doc(siswaLain(), `${base}/aspirations/papan`)));
    await assertSucceeds(getDocs(query(collection(siswaLain(), `${base}/aspirations`), where("board", "==", "published"))));
    await assertFails(getDocs(collection(siswaLain(), `${base}/aspirations`)));
    await assertFails(getDoc(doc(siswaLain(), `${base}/aspirations/baru`)));
    await assertSucceeds(getDoc(doc(siswa(), `${base}/aspirations/baru`)));
    await assertFails(getDoc(doc(siswaSekolahLain(), `${base}/aspirations/papan`)));
  });

  it("identitas pengirim hanya untuk admin, pimpinan, dan Tim Verifikasi", async () => {
    const identity = `${base}/aspirations/baru/private/identity`;
    await assertSucceeds(getDoc(doc(admin(), identity)));
    await assertSucceeds(getDoc(doc(kepsek(), identity)));
    await assertFails(getDoc(doc(siswa(), identity)));
    await assertFails(getDoc(doc(sarpras(), identity)));
    await assertFails(getDoc(doc(sarpras(), `${base}/aspirations/baru`)));
    await assertSucceeds(getDocs(collection(admin(), `${base}/aspirations`)));
  });

  it("dukungan hanya terlihat oleh pemiliknya dan semua penulisan lewat functions", async () => {
    await assertSucceeds(getDoc(doc(siswa(), `${base}/aspirations/papan/supports/siswa-a`)));
    await assertFails(getDoc(doc(siswaLain(), `${base}/aspirations/papan/supports/siswa-a`)));
    await assertFails(setDoc(doc(siswaLain(), `${base}/aspirations/papan/supports/siswa-b`), {createdAt: Timestamp.now()}));
    await assertFails(setDoc(doc(siswa(), `${base}/aspirations/tulis`), {board: "published"}));
    await assertFails(getDocs(query(collection(siswaLain(), `${base}/aspirationOwners`), where("uid", "==", "siswa-a"))));
  });
});
