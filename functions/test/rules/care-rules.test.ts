import {readFileSync} from "node:fs";
import {resolve} from "node:path";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
  type RulesTestEnvironment,
} from "@firebase/rules-unit-testing";
import {addDoc, collection, doc, getDoc, getDocs, serverTimestamp, setDoc, Timestamp, updateDoc} from "firebase/firestore";
import {ref, uploadBytes} from "firebase/storage";
import {afterAll, beforeAll, beforeEach, describe, it} from "vitest";

const SCHOOL = "sekolah-a";
const base = `schools/${SCHOOL}`;
let env: RulesTestEnvironment;

const as = (uid: string, claims: Record<string, unknown> = {}) => env.authenticatedContext(uid, claims);
const siswa = () => as("siswa-a", {sid: SCHOOL, role: "siswa"});
const siswaLain = () => as("siswa-b", {sid: SCHOOL, role: "siswa"});
const bk = () => as("bk-a", {sid: SCHOOL, role: "konselor", units: ["bk_ppks"]});
const bkLain = () => as("bk-b", {sid: SCHOOL, role: "konselor", units: ["bk_ppks"]});
const admin = () => as("admin-a", {sid: SCHOOL, role: "admin", canVerify: true});

const message = (role: string, uid: string, text = "Halo Bu") => ({
  senderUid: uid,
  senderRole: role,
  text,
  imagePath: null,
  createdAt: serverTimestamp(),
});

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
    const conversation = (counselorUid: string | null, status: string) => ({
      studentUid: "siswa-a",
      counselorUid,
      status,
      displayName: "Bunga",
      unreadStudent: 2,
      unreadCounselor: 3,
      createdAt: now,
    });
    await Promise.all([
      setDoc(doc(db, `${base}/conversations/aktif`), conversation("bk-a", "aktif")),
      setDoc(doc(db, `${base}/conversations/menunggu`), conversation(null, "menunggu")),
      setDoc(doc(db, `${base}/conversations/selesai`), conversation("bk-a", "selesai")),
      setDoc(doc(db, `${base}/conversations/aktif/messages/m1`), {senderUid: "siswa-a", senderRole: "siswa", text: "Halo", createdAt: now}),
      setDoc(doc(db, `${base}/conversations/aktif/private/identity`), {name: "Budi", kelas: "XI IPA 1"}),
      setDoc(doc(db, `${base}/conversations/aktif/caseNotes/n1`), {text: "Perlu dipantau", riskLevel: "perhatian", createdAt: now}),
      setDoc(doc(db, `${base}/helpRequests/h1`), {studentUid: "siswa-a", status: "menunggu", urgency: "segera", createdAt: now}),
    ]);
  });
});

describe("rules Butuh Bantuan", () => {
  it("hanya pemilik dan konselor yang membaca permintaan bantuan", async () => {
    await assertSucceeds(getDoc(doc(siswa().firestore(), `${base}/helpRequests/h1`)));
    await assertSucceeds(getDocs(collection(bk().firestore(), `${base}/helpRequests`)));
    await assertFails(getDoc(doc(siswaLain().firestore(), `${base}/helpRequests/h1`)));
    await assertFails(getDocs(collection(admin().firestore(), `${base}/helpRequests`)));
    await assertFails(setDoc(doc(siswa().firestore(), `${base}/helpRequests/baru`), {studentUid: "siswa-a"}));
  });
});

describe("rules Curhat", () => {
  it("percakapan hanya untuk siswa pemilik dan konselor terkait", async () => {
    await assertSucceeds(getDoc(doc(siswa().firestore(), `${base}/conversations/aktif`)));
    await assertSucceeds(getDoc(doc(bk().firestore(), `${base}/conversations/aktif`)));
    await assertFails(getDoc(doc(bkLain().firestore(), `${base}/conversations/aktif`)));
    await assertSucceeds(getDoc(doc(bkLain().firestore(), `${base}/conversations/menunggu`)));
    await assertFails(getDoc(doc(siswaLain().firestore(), `${base}/conversations/aktif`)));
    await assertFails(getDoc(doc(admin().firestore(), `${base}/conversations/aktif`)));
  });

  it("aplikasi hanya boleh menandai pesan sudah dibaca", async () => {
    await assertSucceeds(updateDoc(doc(siswa().firestore(), `${base}/conversations/aktif`), {unreadStudent: 0}));
    await assertFails(updateDoc(doc(siswa().firestore(), `${base}/conversations/aktif`), {unreadStudent: 5}));
    await assertFails(updateDoc(doc(siswa().firestore(), `${base}/conversations/aktif`), {unreadCounselor: 0}));
    await assertFails(updateDoc(doc(siswa().firestore(), `${base}/conversations/aktif`), {status: "selesai"}));
    await assertSucceeds(updateDoc(doc(bk().firestore(), `${base}/conversations/aktif`), {unreadCounselor: 0}));
  });

  it("pesan hanya ditulis peserta dengan peran yang sesuai", async () => {
    const messages = (context: ReturnType<typeof as>, id: string) => collection(context.firestore(), `${base}/conversations/${id}/messages`);
    await assertSucceeds(addDoc(messages(siswa(), "aktif"), message("siswa", "siswa-a")));
    await assertSucceeds(addDoc(messages(bk(), "aktif"), message("konselor", "bk-a")));
    await assertSucceeds(addDoc(messages(siswa(), "menunggu"), message("siswa", "siswa-a")));

    await assertFails(addDoc(messages(siswa(), "aktif"), message("konselor", "siswa-a")));
    await assertFails(addDoc(messages(siswa(), "aktif"), {...message("siswa", "siswa-a"), senderUid: "bk-a"}));
    await assertFails(addDoc(messages(bkLain(), "aktif"), message("konselor", "bk-b")));
    await assertFails(addDoc(messages(siswa(), "selesai"), message("siswa", "siswa-a")));
    await assertFails(addDoc(messages(siswa(), "aktif"), message("siswa", "siswa-a", "x".repeat(4100))));
    await assertFails(addDoc(messages(siswa(), "aktif"), {...message("siswa", "siswa-a"), createdAt: Timestamp.now()}));
    await assertFails(addDoc(messages(siswa(), "aktif"), {...message("siswa", "siswa-a"), riskLevel: "tinggi"}));
    await assertFails(updateDoc(doc(siswa().firestore(), `${base}/conversations/aktif/messages/m1`), {text: "diubah"}));
    await assertFails(getDocs(messages(siswaLain(), "aktif")));
  });

  it("identitas dan catatan kasus hanya untuk konselor yang menangani", async () => {
    await assertSucceeds(getDoc(doc(bk().firestore(), `${base}/conversations/aktif/private/identity`)));
    await assertFails(getDoc(doc(siswa().firestore(), `${base}/conversations/aktif/private/identity`)));
    await assertFails(getDoc(doc(bkLain().firestore(), `${base}/conversations/aktif/caseNotes/n1`)));
    await assertSucceeds(getDocs(collection(bk().firestore(), `${base}/conversations/aktif/caseNotes`)));
    await assertSucceeds(addDoc(collection(bk().firestore(), `${base}/conversations/aktif/caseNotes`), {
      text: "Sudah bertemu, kondisi membaik.",
      riskLevel: "tidak_ada",
      authorName: "Sri Wahyuni",
      createdAt: serverTimestamp(),
    }));
    await assertFails(addDoc(collection(bk().firestore(), `${base}/conversations/aktif/caseNotes`), {
      text: "Catatan",
      riskLevel: "gawat",
      authorName: "Sri Wahyuni",
      createdAt: serverTimestamp(),
    }));
    await assertFails(addDoc(collection(siswa().firestore(), `${base}/conversations/aktif/caseNotes`), {
      text: "Catatan siswa",
      riskLevel: "tidak_ada",
      authorName: "Budi",
      createdAt: serverTimestamp(),
    }));
  });

  it("gambar percakapan hanya untuk peserta", async () => {
    const image = new Uint8Array([0xff, 0xd8, 0xff]);
    const path = (id: string, name: string) => `${base}/conversations/${id}/${name}`;
    await assertSucceeds(uploadBytes(ref(siswa().storage(), path("aktif", "a.jpg")), image, {contentType: "image/jpeg"}));
    await assertSucceeds(uploadBytes(ref(bk().storage(), path("aktif", "b.jpg")), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(bkLain().storage(), path("aktif", "c.jpg")), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(siswa().storage(), path("selesai", "d.jpg")), image, {contentType: "image/jpeg"}));
    await assertFails(uploadBytes(ref(siswa().storage(), path("aktif", "e.pdf")), image, {contentType: "application/pdf"}));
  });
});
