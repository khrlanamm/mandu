import {HttpsError, type FunctionsErrorCode} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";

/** Error yang aman ditampilkan ke klien; diteruskan sebagai HttpsError dengan kode yang sama. */
export class AppError extends Error {
  constructor(
    readonly code: FunctionsErrorCode,
    message: string,
  ) {
    super(message);
    this.name = "AppError";
  }
}

/** Ubah error apa pun menjadi HttpsError tanpa membocorkan detail internal. */
export function toHttpsError(error: unknown, context: string): HttpsError {
  if (error instanceof HttpsError) return error;
  if (error instanceof AppError) {
    logger.warn(`${context}: ${error.message}`);
    return new HttpsError(error.code, error.message);
  }
  logger.error(`${context}: error tak terduga`, error);
  return new HttpsError("internal", "Terjadi kesalahan pada server.");
}
