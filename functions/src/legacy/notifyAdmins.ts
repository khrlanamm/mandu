import {FieldValue, type DocumentReference, type DocumentSnapshot, type Firestore} from "firebase-admin/firestore";
import type {Message, Notification} from "firebase-admin/messaging";
import {AppError} from "../core/errors";

/** Laporan yang lebih lama dari ini tidak lagi memicu notifikasi. */
export const MAX_REPORT_AGE_MS = 10 * 60 * 1000;
const MAX_DESCRIPTION_LENGTH = 100;
const REPORT_ID_PATTERN = /^[A-Za-z0-9_-]{1,128}$/;
const INVALID_TOKEN_CODES = new Set([
  "messaging/registration-token-not-registered",
  "messaging/invalid-registration-token",
]);

interface Logger {
  info(...args: unknown[]): void;
  warn(...args: unknown[]): void;
  error(...args: unknown[]): void;
}

export interface NotifyParams {
  db: Firestore;
  messaging: {send(message: Message): Promise<string>};
  logger: Logger;
  uid: string;
  reportId?: unknown;
  now?: number;
}

export type NotifyResult = {success: true; message: string} | {success: true; sent: number; failed: number};

/**
 * Laporan milik pemanggil. Aplikasi Kotlin v3 tidak mengirim reportId,
 * jadi untuk klien lama dipakai laporan terbaru milik pemanggil.
 */
async function findCallerReport(db: Firestore, uid: string, reportId: string | null): Promise<DocumentSnapshot> {
  const reports = db.collection("reports");
  if (reportId) {
    const doc = await reports.doc(reportId).get();
    if (!doc.exists || doc.get("userId") !== uid) {
      throw new AppError("not-found", "Report not found.");
    }
    return doc;
  }

  const snapshot = await reports.where("userId", "==", uid).orderBy("timestamp", "desc").limit(1).get();
  if (snapshot.empty) {
    throw new AppError("not-found", "Report not found.");
  }
  return snapshot.docs[0];
}

/** Menandai laporan sudah dinotifikasi. Bernilai false bila sudah pernah. */
function claimNotification(db: Firestore, ref: DocumentReference): Promise<boolean> {
  return db.runTransaction(async (tx) => {
    const snapshot = await tx.get(ref);
    if (snapshot.get("notifiedAt")) return false;
    tx.update(ref, {notifiedAt: FieldValue.serverTimestamp()});
    return true;
  });
}

function buildNotification(report: FirebaseFirestore.DocumentData): Notification {
  const peran = report.peran || "Seseorang";
  const lokasi = report.lokasi || "Lokasi tidak spesifik.";
  const tanggal = report.tanggalBullying || "Tanggal tidak diketahui.";
  let deskripsi: string = report.deskripsi || "Tidak ada deskripsi.";
  if (deskripsi.length > MAX_DESCRIPTION_LENGTH) {
    deskripsi = `${deskripsi.substring(0, MAX_DESCRIPTION_LENGTH - 3)}...`;
  }

  const notification: Notification = {
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
 */
export async function notifyAdminsOfReport({db, messaging, logger, uid, reportId, now = Date.now()}: NotifyParams): Promise<NotifyResult> {
  if (reportId !== undefined && reportId !== null && !(typeof reportId === "string" && REPORT_ID_PATTERN.test(reportId))) {
    throw new AppError("invalid-argument", "Invalid reportId.");
  }

  const reportDoc = await findCallerReport(db, uid, (reportId as string | undefined) || null);

  const createdAt = reportDoc.get("timestamp");
  if (!createdAt || typeof createdAt.toMillis !== "function" || now - createdAt.toMillis() > MAX_REPORT_AGE_MS) {
    throw new AppError("failed-precondition", "Report is too old to notify.");
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

  const notification = buildNotification(reportDoc.data() ?? {});
  const results = await Promise.allSettled(admins.map((admin) => messaging.send({
    token: admin.get("fcmToken"),
    notification,
    data: {target_activity: "HistoryActivity"},
    android: {notification: {sound: "default"}},
    apns: {payload: {aps: {sound: "default"}}},
  })));

  let sent = 0;
  const cleanups: Promise<unknown>[] = [];
  results.forEach((result, index) => {
    const admin = admins[index];
    if (result.status === "fulfilled") {
      sent++;
      return;
    }
    logger.error(`Gagal mengirim notifikasi ke admin ${admin.id}`, result.reason);
    const code = (result.reason as {code?: string} | undefined)?.code;
    if (code && INVALID_TOKEN_CODES.has(code)) {
      // Token tidak berlaku lagi (mis. admin logout). Hapus bila belum diganti token baru.
      cleanups.push(admin.ref
        .update({fcmToken: FieldValue.delete()}, {lastUpdateTime: admin.updateTime})
        .catch((error: Error) => logger.warn(`Token admin ${admin.id} tidak dihapus: ${error.message}`)));
    }
  });
  await Promise.all(cleanups);

  const failed = results.length - sent;
  logger.info(`Notifikasi laporan ${reportDoc.id}: berhasil ${sent}, gagal ${failed}.`);
  return {success: true, sent, failed};
}
