import {readFileSync} from "node:fs";
import {resolve} from "node:path";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
  type RulesTestEnvironment,
} from "@firebase/rules-unit-testing";
import {collection, doc, getDoc, getDocs, query, serverTimestamp, setDoc, Timestamp, where} from "firebase/firestore";
import {afterAll, beforeAll, beforeEach, describe, it} from "vitest";

const SCHOOL = "sekolah-a";
let env: RulesTestEnvironment;

const as = (uid: string, claims: Record<string, unknown> = {}) => env.authenticatedContext(uid, claims).firestore();
const siswa = () => as("siswa-a", {sid: SCHOOL, role: "siswa"});
const siswaSekolahLain = () => as("siswa-z", {sid: "sekolah-b", role: "siswa"});
const admin = () => as("admin-a", {sid: SCHOOL, role: "admin", canVerify: true});
const superadmin = () => as("superadmin", {sa: true});

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
      setDoc(doc(db, "articles/terbit"), {title: "Anti-perundungan", published: true, createdAt: now}),
      setDoc(doc(db, "articles/draf"), {title: "Draf", published: false, createdAt: now}),
      setDoc(doc(db, `schools/${SCHOOL}/articles/terbit`), {title: "Layanan BK", published: true, createdAt: now}),
      setDoc(doc(db, `schools/${SCHOOL}/articles/draf`), {title: "Draf sekolah", published: false, createdAt: now}),
      setDoc(doc(db, "users/siswa-a/bookmarks/terbit"), {scope: "global", schoolId: null, title: "Anti-perundungan", createdAt: now}),
    ]);
  });
});

describe("rules Edukasi", () => {
  it("artikel terbit dibaca semua pengguna, draf hanya penulisnya", async () => {
    await assertSucceeds(getDoc(doc(siswa(), "articles/terbit")));
    await assertFails(getDoc(doc(siswa(), "articles/draf")));
    await assertSucceeds(getDoc(doc(superadmin(), "articles/draf")));
    await assertSucceeds(getDocs(query(collection(siswa(), "articles"), where("published", "==", true))));
    await assertFails(getDocs(collection(siswa(), "articles")));
  });

  it("artikel sekolah hanya untuk anggota sekolah itu", async () => {
    await assertSucceeds(getDoc(doc(siswa(), `schools/${SCHOOL}/articles/terbit`)));
    await assertFails(getDoc(doc(siswa(), `schools/${SCHOOL}/articles/draf`)));
    await assertSucceeds(getDoc(doc(admin(), `schools/${SCHOOL}/articles/draf`)));
    await assertFails(getDoc(doc(siswaSekolahLain(), `schools/${SCHOOL}/articles/terbit`)));
    await assertFails(setDoc(doc(admin(), `schools/${SCHOOL}/articles/baru`), {title: "Tulis langsung", published: true}));
  });

  it("bookmark hanya milik pemiliknya", async () => {
    await assertSucceeds(getDocs(collection(siswa(), "users/siswa-a/bookmarks")));
    await assertSucceeds(setDoc(doc(siswa(), "users/siswa-a/bookmarks/baru"), {
      scope: "school",
      schoolId: SCHOOL,
      title: "Layanan BK",
      createdAt: serverTimestamp(),
    }));
    await assertFails(setDoc(doc(siswa(), "users/siswa-a/bookmarks/palsu"), {
      scope: "school",
      schoolId: SCHOOL,
      title: "Layanan BK",
      createdAt: Timestamp.now(),
    }));
    await assertFails(getDocs(collection(siswaSekolahLain(), "users/siswa-a/bookmarks")));
    await assertFails(setDoc(doc(siswaSekolahLain(), "users/siswa-a/bookmarks/serobot"), {
      scope: "global",
      schoolId: null,
      title: "x",
      createdAt: serverTimestamp(),
    }));
  });
});
