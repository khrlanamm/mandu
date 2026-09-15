const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const logger = require("firebase-functions/logger");
const {notifyAdminsOfReport, NotifyError} = require("./notify");

initializeApp();

/**
 * Dipanggil aplikasi setelah laporan tersimpan: `{reportId}`.
 * Isi notifikasi dibaca dari dokumen laporan, sehingga klien tidak bisa
 * mengirim teks atau gambar sembarangan ke admin.
 */
exports.sendReportNotification = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "The function must be called while authenticated.");
  }

  try {
    return await notifyAdminsOfReport({
      db: getFirestore(),
      messaging: getMessaging(),
      logger,
      uid: request.auth.uid,
      reportId: (request.data || {}).reportId,
    });
  } catch (error) {
    if (error instanceof NotifyError) {
      logger.warn(`Permintaan notifikasi ditolak untuk ${request.auth.uid}: ${error.message}`);
      throw new HttpsError(error.code, error.message);
    }
    logger.error("Terjadi error tak terduga dalam fungsi:", error);
    throw new HttpsError("internal", "An unexpected error occurred.");
  }
});
