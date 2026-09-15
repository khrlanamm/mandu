const {FieldValue} = require("firebase-admin/firestore");

/** Laporan yang lebih lama dari ini tidak lagi memicu notifikasi. */
const MAX_REPORT_AGE_MS = 10 * 60 * 1000;
const MAX_DESCRIPTION_LENGTH = 100;
const REPORT_ID_PATTERN = /^[A-Za-z0-9_-]{1,128}$/;
const INVALID_TOKEN_CODES = [
  "messaging/registration-token-not-registered",
  "messaging/invalid-registration-token",
];

/**
 * Error yang diteruskan ke klien sebagai HttpsError dengan kode yang sama.
 */
class NotifyError extends Error {
  /**
   * @param {string} code Kode HttpsError, mis. "not-found".
   * @param {string} message Pesan untuk klien.
   */
  constructor(code, message) {
    super(message);
    this.code = code;
  }
}

/**
 * Laporan milik pemanggil. Aplikasi Kotlin v3 tidak mengirim reportId,
 * jadi untuk klien lama dipakai laporan terbaru milik pemanggil.
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} uid
 * @param {?string} reportId
 * @return {Promise<FirebaseFirestore.DocumentSnapshot>}
 */
async function findCallerReport(db, uid, reportId) {
  const reports = db.collection("reports");
  if (reportId) {
    const doc = await reports.doc(reportId).get();
    if (!doc.exists || doc.get("userId") !== uid) {
      throw new NotifyError("not-found", "Report not found.");
    }
    return doc;
  }

  const snapshot = await reports.where("userId", "==", uid).orderBy("timestamp", "desc").limit(1).get();
  if (snapshot.empty) {
    throw new NotifyError("not-found", "Report not found.");
  }
  return snapshot.docs[0];
}

/**
 * Menandai laporan sudah dinotifikasi. Bernilai false bila sudah pernah.
 * @param {FirebaseFirestore.Firestore} db
 * @param {FirebaseFirestore.DocumentReference} ref
 * @return {Promise<boolean>}
 */
async function claimNotification(db, ref) {
  return db.runTransaction(async (tx) => {
    const snapshot = await tx.get(ref);
    if (snapshot.get("notifiedAt")) {
      return false;
    }
    tx.update(ref, {notifiedAt: FieldValue.serverTimestamp()});
    return true;
  });
}

/**
 * @param {FirebaseFirestore.DocumentData} report
 * @return {Object} Payload `notification` FCM.
 */
function buildNotification(report) {
  const peran = report.peran || "Seseorang";
  const lokasi = report.lokasi || "Lokasi tidak spesifik.";
  const tanggal = report.tanggalBullying || "Tanggal tidak diketahui.";
  let deskripsi = report.deskripsi || "Tidak ada deskripsi.";
  if (deskripsi.length > MAX_DESCRIPTION_LENGTH) {
    deskripsi = `${deskripsi.substring(0, MAX_DESCRIPTION_LENGTH - 3)}...`;
  }

  const notification = {
    title: `Laporan Baru dari Seorang ${peran}`,
    body: `Tanggal: ${tanggal}\nLokasi: ${lokasi}\n${deskripsi}`,
  };
  if (typeof report.urlBukti === "string" && report.urlBukti.startsWith("https://")) {
    notification.imageUrl = report.urlBukti;
  }
  return notification;
}

/**
 * Kirim notifikasi laporan baru ke semua admin yang punya fcmToken.
 * Hanya pemilik laporan yang boleh memicu, maksimal sekali per laporan,
 * dan hanya untuk laporan yang baru dibuat.
 * @param {Object} params
 * @param {FirebaseFirestore.Firestore} params.db
 * @param {Object} params.messaging Instance Messaging dari firebase-admin.
 * @param {Object} params.logger
 * @param {string} params.uid UID pemanggil.
 * @param {*} params.reportId ID laporan dari klien (tidak ada untuk klien lama).
 * @param {number=} params.now Waktu sekarang dalam milidetik.
 * @return {Promise<Object>}
 */
async function notifyAdminsOfReport({db, messaging, logger, uid, reportId, now = Date.now()}) {
  if (reportId !== undefined && reportId !== null && !(typeof reportId === "string" && REPORT_ID_PATTERN.test(reportId))) {
    throw new NotifyError("invalid-argument", "Invalid reportId.");
  }

  const reportDoc = await findCallerReport(db, uid, reportId || null);

  const createdAt = reportDoc.get("timestamp");
  if (!createdAt || typeof createdAt.toMillis !== "function" || now - createdAt.toMillis() > MAX_REPORT_AGE_MS) {
    throw new NotifyError("failed-precondition", "Report is too old to notify.");
  }

  if (!(await claimNotification(db, reportDoc.ref))) {
    logger.info(`Laporan ${reportDoc.id} sudah pernah dinotifikasi.`);
    return {success: true, message: "Already notified."};
  }

  const adminsSnapshot = await db.collection("admins").get();
  const admins = adminsSnapshot.docs.filter((doc) => {
    const token = doc.get("fcmToken");
    return typeof token === "string" && token !== "";
  });
  if (admins.length === 0) {
    logger.info("Tidak ada token FCM admin yang valid.");
    return {success: true, message: "No valid tokens found."};
  }

  const notification = buildNotification(reportDoc.data());
  const results = await Promise.allSettled(admins.map((admin) => messaging.send({
    token: admin.get("fcmToken"),
    notification,
    data: {target_activity: "HistoryActivity"},
    android: {notification: {sound: "default"}},
    apns: {payload: {aps: {sound: "default"}}},
  })));

  let sent = 0;
  const cleanups = [];
  results.forEach((result, index) => {
    const admin = admins[index];
    if (result.status === "fulfilled") {
      sent++;
      return;
    }
    logger.error(`Gagal mengirim notifikasi ke admin ${admin.id}`, result.reason);
    const code = result.reason && result.reason.code;
    if (INVALID_TOKEN_CODES.includes(code)) {
      // Token tidak berlaku lagi (mis. admin logout). Hapus bila belum diganti token baru.
      cleanups.push(admin.ref
          .update({fcmToken: FieldValue.delete()}, {lastUpdateTime: admin.updateTime})
          .catch((error) => logger.warn(`Token admin ${admin.id} tidak dihapus: ${error.message}`)));
    }
  });
  await Promise.all(cleanups);

  const failed = results.length - sent;
  logger.info(`Notifikasi laporan ${reportDoc.id}: berhasil ${sent}, gagal ${failed}.`);
  return {success: true, sent, failed};
}

module.exports = {notifyAdminsOfReport, NotifyError, MAX_REPORT_AGE_MS};
