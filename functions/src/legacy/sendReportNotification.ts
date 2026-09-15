import {onCall} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import {requireAuth} from "../core/claims";
import {toHttpsError} from "../core/errors";
import {db, messaging} from "../core/firebase";
import {notifyAdminsOfReport} from "./notifyAdmins";

/**
 * Dipanggil aplikasi setelah laporan tersimpan: `{reportId}`.
 * Isi notifikasi dibaca dari dokumen laporan, sehingga klien tidak bisa
 * mengirim teks atau gambar sembarangan ke admin.
 */
export const sendReportNotification = onCall(async (request) => {
  try {
    const {uid} = requireAuth(request);
    return await notifyAdminsOfReport({
      db: db(),
      messaging: messaging(),
      logger,
      uid,
      reportId: (request.data as {reportId?: unknown} | null | undefined)?.reportId,
    });
  } catch (error) {
    throw toHttpsError(error, "sendReportNotification");
  }
});
