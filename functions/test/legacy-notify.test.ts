import {beforeAll, beforeEach, describe, expect, it} from "vitest";
import {getApps, initializeApp} from "firebase-admin/app";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import type {Message} from "firebase-admin/messaging";
import {MAX_REPORT_AGE_MS, notifyAdminsOfReport} from "../src/legacy/notifyAdmins";

if (!process.env.FIRESTORE_EMULATOR_HOST) {
  throw new Error("Tes ini harus dijalankan dengan Firestore emulator (npm run test:emulator).");
}

if (getApps().length === 0) initializeApp({projectId: "demo-mandu"});
const db = getFirestore();
const silentLogger = {info: () => {}, warn: () => {}, error: () => {}};

const tokenOf = (message: Message) => ("token" in message ? message.token : "");

const fakeMessaging = (failures: Record<string, string> = {}) => {
  const sent: Message[] = [];
  return {
    sent,
    send: async (message: Message) => {
      const failure = failures[tokenOf(message)];
      if (failure) throw Object.assign(new Error("send failed"), {code: failure});
      sent.push(message);
      return "message-id";
    },
  };
};

const report = (userId: string, overrides: Record<string, unknown> = {}) => ({
  userId,
  peran: "Korban",
  tanggalBullying: "15/09/2026",
  lokasi: "Kantin",
  frekuensi: "Sering",
  deskripsi: "Kronologi asli dari Firestore",
  nomorWhatsapp: "081234567890",
  urlBukti: null,
  status: "terlapor",
  timestamp: Timestamp.now(),
  ...overrides,
});

const clearCollection = async (name: string) => {
  const snapshot = await db.collection(name).get();
  await Promise.all(snapshot.docs.map((doc) => doc.ref.delete()));
};

describe("notifyAdminsOfReport (legacy)", () => {
  beforeAll(async () => {
    await clearCollection("admins");
    await db.collection("admins").doc("admin-1").set({fcmToken: "token-1"});
  });

  beforeEach(async () => {
    await clearCollection("reports");
  });

  it("memakai isi laporan dari Firestore dan hanya sekali per laporan", async () => {
    await db.collection("reports").doc("r1").set(report("alice", {urlBukti: "https://example.com/bukti.jpg"}));
    const messaging = fakeMessaging();
    const params = {db, messaging, logger: silentLogger, uid: "alice", reportId: "r1"};

    const first = await notifyAdminsOfReport(params);
    expect(first).toMatchObject({sent: 1});
    expect(messaging.sent[0].notification?.title).toBe("Laporan Baru dari Seorang Korban");
    expect(messaging.sent[0].notification?.body).toContain("Kronologi asli dari Firestore");
    expect(messaging.sent[0].notification?.imageUrl).toBe("https://example.com/bukti.jpg");
    expect((await db.collection("reports").doc("r1").get()).get("notifiedAt")).toBeTruthy();

    const second = await notifyAdminsOfReport(params);
    expect(second).toMatchObject({message: "Already notified."});
    expect(messaging.sent).toHaveLength(1);
  });

  it("menolak laporan milik pengguna lain", async () => {
    await db.collection("reports").doc("r2").set(report("bob"));
    await expect(notifyAdminsOfReport({db, messaging: fakeMessaging(), logger: silentLogger, uid: "alice", reportId: "r2"}))
      .rejects.toMatchObject({code: "not-found"});
  });

  it("menolak reportId yang tidak valid", async () => {
    await expect(notifyAdminsOfReport({db, messaging: fakeMessaging(), logger: silentLogger, uid: "alice", reportId: "reports/x/y"}))
      .rejects.toMatchObject({code: "invalid-argument"});
  });

  it("menolak laporan lama", async () => {
    const old = Timestamp.fromMillis(Date.now() - MAX_REPORT_AGE_MS - 60_000);
    await db.collection("reports").doc("r3").set(report("alice", {timestamp: old}));
    await expect(notifyAdminsOfReport({db, messaging: fakeMessaging(), logger: silentLogger, uid: "alice", reportId: "r3"}))
      .rejects.toMatchObject({code: "failed-precondition"});
  });

  it("klien lama tanpa reportId memakai laporan terbaru milik pemanggil", async () => {
    await db.collection("reports").doc("old").set(report("alice", {lokasi: "Lama", timestamp: Timestamp.fromMillis(Date.now() - 60_000)}));
    await db.collection("reports").doc("new").set(report("alice", {lokasi: "Terbaru"}));
    await db.collection("reports").doc("other").set(report("bob", {lokasi: "Milik Bob"}));
    const messaging = fakeMessaging();

    await notifyAdminsOfReport({db, messaging, logger: silentLogger, uid: "alice"});
    expect(messaging.sent[0].notification?.body).toContain("Lokasi: Terbaru");
  });

  it("menghapus token admin yang sudah tidak terdaftar", async () => {
    await db.collection("admins").doc("admin-2").set({fcmToken: "dead-token"});
    await db.collection("reports").doc("r4").set(report("alice"));
    const messaging = fakeMessaging({"dead-token": "messaging/registration-token-not-registered"});

    const result = await notifyAdminsOfReport({db, messaging, logger: silentLogger, uid: "alice", reportId: "r4"});
    expect(result).toMatchObject({sent: 1, failed: 1});
    const admin2 = await db.collection("admins").doc("admin-2").get();
    expect(admin2.exists).toBe(true);
    expect(admin2.get("fcmToken")).toBeUndefined();
    expect((await db.collection("admins").doc("admin-1").get()).get("fcmToken")).toBe("token-1");
  });
});
