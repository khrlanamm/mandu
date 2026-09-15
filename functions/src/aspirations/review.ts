import {FieldValue, Timestamp} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {parsePayload} from "../core/validation";
import {
  ASPIRATION_STATUS_LABELS,
  ASPIRATION_STATUSES,
  BOARD_STATES,
  studentAspirationRoute,
  type AspirationDoc,
} from "../domain/aspirations";
import {notifyUsers} from "../notifications/notify";
import {isVerifier, staffName} from "../tickets/access";
import {aspirationOwnerRef, aspirationsRef} from "./submit";

const ids = {schoolId: z.string().min(1), aspirationId: z.string().min(1)};

const reviewSchema = z.object({
  ...ids,
  status: z.enum(ASPIRATION_STATUSES).optional(),
  response: z.string().trim().min(5, "Tanggapan minimal 5 karakter.").max(2000).optional(),
  board: z.enum(BOARD_STATES).optional(),
}).refine((input) => input.status || input.response || input.board, "Tidak ada perubahan yang dikirim.");

/** Admin/Tim Verifikasi mengubah status, memberi tanggapan resmi, dan mengatur tampil di papan. */
export async function reviewAspiration(caller: Caller, data: unknown): Promise<{status: string; board: string}> {
  const input = parsePayload(reviewSchema, data);
  const {schoolId, aspirationId} = input;
  if (!isVerifier(caller, schoolId)) {
    throw new AppError("permission-denied", "Hanya admin sekolah atau Tim Verifikasi yang dapat menanggapi aspirasi.");
  }
  const actorName = await staffName(caller, schoolId);
  const ref = aspirationsRef(schoolId).doc(aspirationId);

  const {before, after} = await db().runTransaction(async (tx) => {
    const current = (await tx.get(ref)).data() as AspirationDoc | undefined;
    if (!current) throw new AppError("not-found", "Aspirasi tidak ditemukan.");
    const now = Timestamp.now();
    // Tanggapan pertama tanpa status baru berarti aspirasi sedang ditinjau.
    const status = input.status ?? (input.response && current.status === "diterima" ? "ditinjau" : current.status);
    const board = input.board ?? current.board;
    const response = input.response ? {message: input.response, respondedByName: actorName, respondedAt: now} : current.response;

    tx.update(ref, {
      status,
      board,
      response,
      publishedAt: board === "published" ? (current.publishedAt ?? now) : null,
      updatedAt: now,
    });
    return {before: current, after: {status, board, response}};
  });

  const statusChanged = before.status !== after.status;
  if (statusChanged || input.response) {
    const owner = (await aspirationOwnerRef(schoolId, aspirationId).get()).get("uid") as string | undefined;
    if (owner) {
      await notifyUsers([owner], {
        type: "aspirasi_ditanggapi",
        title: `Aspirasi ${before.number}: ${ASPIRATION_STATUS_LABELS[after.status]}`,
        body: input.response?.slice(0, 120) ?? "Status aspirasimu diperbarui.",
        route: studentAspirationRoute(aspirationId),
        schoolId,
      });
    }
  }
  return {status: after.status, board: after.board};
}

const supportSchema = z.object({...ids, support: z.boolean()});

/** Siswa mendukung (atau batal mendukung) aspirasi di papan. Satu dukungan per siswa. */
export async function supportAspiration(caller: Caller, data: unknown): Promise<{supported: boolean; supportCount: number}> {
  const {schoolId, aspirationId, support} = parsePayload(supportSchema, data);
  if (caller.claims.sid !== schoolId || caller.claims.role !== "siswa") {
    throw new AppError("permission-denied", "Hanya siswa sekolah ini yang dapat memberi dukungan.");
  }
  const ref = aspirationsRef(schoolId).doc(aspirationId);
  const supportRef = ref.collection("supports").doc(caller.uid);

  return db().runTransaction(async (tx) => {
    const [aspiration, existing] = await Promise.all([tx.get(ref), tx.get(supportRef)]);
    const current = aspiration.data() as AspirationDoc | undefined;
    if (!current || current.board !== "published") throw new AppError("not-found", "Aspirasi tidak ada di papan.");

    if (support === existing.exists) return {supported: support, supportCount: current.supportCount};
    if (support) {
      tx.create(supportRef, {createdAt: FieldValue.serverTimestamp()});
    } else {
      tx.delete(supportRef);
    }
    const supportCount = Math.max(0, current.supportCount + (support ? 1 : -1));
    tx.update(ref, {supportCount});
    return {supported: support, supportCount};
  });
}
