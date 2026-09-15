import {FieldValue} from "firebase-admin/firestore";
import {readClaims, type ManduClaims} from "../core/claims";
import {auth} from "../core/firebase";
import {memberRef, userRef} from "../core/refs";
import type {MemberDoc, UserDoc} from "../domain/models";

/** Custom claims yang seharusnya dimiliki pengguna berdasarkan dokumen Firestore. */
export function computeClaims(user: UserDoc | undefined, member: MemberDoc | undefined): Record<string, unknown> {
  const claims: Record<string, unknown> = {};
  if (user?.isSuperadmin) claims.sa = true;
  if (user?.schoolId && member?.status === "active") {
    claims.sid = user.schoolId;
    claims.role = member.role;
    if (member.units.length > 0) claims.units = member.units;
    if (member.canVerify || member.role === "admin") claims.canVerify = true;
  }
  return claims;
}

const normalized = (claims: ManduClaims) => JSON.stringify({
  sa: claims.sa === true,
  sid: claims.sid ?? null,
  role: claims.role ?? null,
  units: [...(claims.units ?? [])].sort(),
  canVerify: claims.canVerify === true,
});

export function claimsEqual(current: ManduClaims, expected: Record<string, unknown>): boolean {
  return normalized(current) === normalized(readClaims(expected));
}

/** Tulis ulang custom claims dari Firestore dan beri tahu aplikasi lewat claimsVersion. */
export async function syncClaims(uid: string): Promise<Record<string, unknown>> {
  const user = (await userRef(uid).get()).data() as UserDoc | undefined;
  const member = user?.schoolId ? (await memberRef(user.schoolId, uid).get()).data() as MemberDoc | undefined : undefined;
  const claims = computeClaims(user, member);

  await auth().setCustomUserClaims(uid, claims);
  if (user) {
    await userRef(uid).update({claimsVersion: FieldValue.increment(1), updatedAt: FieldValue.serverTimestamp()});
  }
  return claims;
}
