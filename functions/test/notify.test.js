// Jalankan dengan Firestore emulator:
//   firebase emulators:exec --only firestore --project demo-mandu "npm --prefix functions test"
const {describe, it, before, beforeEach} = require("node:test");
const assert = require("node:assert/strict");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, Timestamp} = require("firebase-admin/firestore");
const {notifyAdminsOfReport, MAX_REPORT_AGE_MS} = require("../notify");

if (!process.env.FIRESTORE_EMULATOR_HOST) {
  throw new Error("Tes ini harus dijalankan dengan Firestore emulator.");
}

initializeApp({projectId: "demo-mandu"});
const db = getFirestore();
const silentLogger = {info: () => {}, warn: () => {}, error: () => {}};

const fakeMessaging = (failures = {}) => {
  const sent = [];
  return {
    sent,
    send: async (message) => {
      if (failures[message.token]) {
        const error = new Error("send failed");
        error.code = failures[message.token];
        throw error;
      }
      sent.push(message);
      return "message-id";
    },
  };
};

const report = (userId, overrides = {}) => ({
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

const clearCollection = async (name) => {
  const snapshot = await db.collection(name).get();
  await Promise.all(snapshot.docs.map((doc) => doc.ref.delete()));
};

const expectNotifyError = async (promise, code) => {
  await assert.rejects(promise, (error) => error.code === code);
};

describe("notifyAdminsOfReport", () => {
  before(async () => {
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
    assert.equal(first.sent, 1);
    assert.equal(messaging.sent[0].notification.title, "Laporan Baru dari Seorang Korban");
    assert.match(messaging.sent[0].notification.body, /Kronologi asli dari Firestore/);
    assert.equal(messaging.sent[0].notification.imageUrl, "https://example.com/bukti.jpg");
    assert.ok((await db.collection("reports").doc("r1").get()).get("notifiedAt"));

    const second = await notifyAdminsOfReport(params);
    assert.equal(second.message, "Already notified.");
    assert.equal(messaging.sent.length, 1);
  });

  it("menolak laporan milik pengguna lain", async () => {
    await db.collection("reports").doc("r2").set(report("bob"));
    await expectNotifyError(
        notifyAdminsOfReport({db, messaging: fakeMessaging(), logger: silentLogger, uid: "alice", reportId: "r2"}),
        "not-found",
    );
  });

  it("menolak reportId yang tidak valid", async () => {
    await expectNotifyError(
        notifyAdminsOfReport({db, messaging: fakeMessaging(), logger: silentLogger, uid: "alice", reportId: "reports/x/y"}),
        "invalid-argument",
    );
  });

  it("menolak laporan lama", async () => {
    const old = Timestamp.fromMillis(Date.now() - MAX_REPORT_AGE_MS - 60 * 1000);
    await db.collection("reports").doc("r3").set(report("alice", {timestamp: old}));
    await expectNotifyError(
        notifyAdminsOfReport({db, messaging: fakeMessaging(), logger: silentLogger, uid: "alice", reportId: "r3"}),
        "failed-precondition",
    );
  });

  it("klien lama tanpa reportId memakai laporan terbaru milik pemanggil", async () => {
    await db.collection("reports").doc("old").set(report("alice", {
      lokasi: "Lama",
      timestamp: Timestamp.fromMillis(Date.now() - 60 * 1000),
    }));
    await db.collection("reports").doc("new").set(report("alice", {lokasi: "Terbaru"}));
    await db.collection("reports").doc("other").set(report("bob", {lokasi: "Milik Bob"}));
    const messaging = fakeMessaging();

    await notifyAdminsOfReport({db, messaging, logger: silentLogger, uid: "alice"});
    assert.match(messaging.sent[0].notification.body, /Lokasi: Terbaru/);
  });

  it("menghapus token admin yang sudah tidak terdaftar", async () => {
    await db.collection("admins").doc("admin-2").set({fcmToken: "dead-token"});
    await db.collection("reports").doc("r4").set(report("alice"));
    const messaging = fakeMessaging({"dead-token": "messaging/registration-token-not-registered"});

    const result = await notifyAdminsOfReport({db, messaging, logger: silentLogger, uid: "alice", reportId: "r4"});
    assert.equal(result.sent, 1);
    assert.equal(result.failed, 1);
    const admin2 = await db.collection("admins").doc("admin-2").get();
    assert.equal(admin2.exists, true);
    assert.equal(admin2.get("fcmToken"), undefined);
    assert.equal((await db.collection("admins").doc("admin-1").get()).get("fcmToken"), "token-1");
  });
});
