import {createHash} from "node:crypto";
import {Timestamp} from "firebase-admin/firestore";
import {AppError} from "./errors";
import {db} from "./firebase";

/** Kunci pembatas yang tidak menyimpan data mentah (mis. alamat IP). */
export const rateLimitKey = (...parts: string[]) => createHash("sha256").update(parts.join("|")).digest("hex").slice(0, 40);

/**
 * Hitung satu pemakaian dalam jendela waktu; tolak bila sudah mencapai [limit].
 * Dokumen `rateLimits/{key}` punya `expiresAt` untuk TTL policy Firestore.
 */
export async function consumeRateLimit(key: string, limit: number, windowMs: number, message: string): Promise<void> {
  const ref = db().collection("rateLimits").doc(key);
  await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as {count: number; windowStart: number} | undefined;
    const now = Date.now();
    if (!current || now - current.windowStart >= windowMs) {
      tx.set(ref, {count: 1, windowStart: now, expiresAt: Timestamp.fromMillis(now + windowMs)});
      return;
    }
    if (current.count >= limit) throw new AppError("resource-exhausted", message);
    tx.update(ref, {count: current.count + 1});
  });
}
