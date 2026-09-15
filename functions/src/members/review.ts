import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import {syncClaims} from "../accounts/claims";
import type {Caller} from "../core/claims";
import {db} from "../core/firebase";
import {requireSchoolAdminOrSuperadmin} from "../core/permissions";
import {memberRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {MemberDoc, UserDoc} from "../domain/models";

const DEFAULT_REJECTION = "Tidak dapat diverifikasi sebagai siswa sekolah ini.";

const schema = z.object({
  schoolId: z.string().min(1),
  uids: z.array(z.string().min(1)).min(1).max(100),
  approve: z.boolean(),
  reason: z.string().trim().max(200).optional(),
});

/** Admin menyetujui atau menolak permintaan bergabung (bisa sekaligus banyak). */
export async function reviewMembers(caller: Caller, data: unknown): Promise<{updated: string[]; skipped: string[]}> {
  const input = parsePayload(schema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);

  const updated: string[] = [];
  const skipped: string[] = [];
  for (const uid of new Set(input.uids)) {
    const changed = await db().runTransaction(async (tx) => {
      const [memberSnap, userSnap] = await Promise.all([tx.get(memberRef(input.schoolId, uid)), tx.get(userRef(uid))]);
      const member = memberSnap.data() as MemberDoc | undefined;
      const user = userSnap.data() as UserDoc | undefined;
      if (member?.status !== "pending" || user?.status !== "pending" || user.schoolId !== input.schoolId) {
        return false;
      }
      const now = FieldValue.serverTimestamp();
      const status = input.approve ? "active" : "rejected";
      tx.update(memberSnap.ref, {
        status,
        reviewedBy: caller.uid,
        reviewedAt: now,
        rejectionReason: input.approve ? null : input.reason || DEFAULT_REJECTION,
        updatedAt: now,
      });
      tx.update(userSnap.ref, {status, updatedAt: now});
      return true;
    });

    if (!changed) {
      skipped.push(uid);
      continue;
    }
    updated.push(uid);
    if (input.approve) await syncClaims(uid);
  }
  return {updated, skipped};
}
