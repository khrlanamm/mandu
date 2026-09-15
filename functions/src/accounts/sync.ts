import type {Caller, SchoolRole} from "../core/claims";
import {AppError} from "../core/errors";
import {auth} from "../core/firebase";
import {memberRef, userRef} from "../core/refs";
import {CONSENT_VERSION} from "../domain/catalog";
import type {AccountStatus, MemberDoc, UserDoc} from "../domain/models";
import {acceptPendingInvitation} from "../members/invitations";
import {claimsEqual, computeClaims, syncClaims} from "./claims";
import {ensureUserDoc, isGuestRecord} from "./users";

export interface AccountSummary {
  uid: string;
  displayName: string;
  email: string | null;
  isSuperadmin: boolean;
  status: AccountStatus;
  schoolId: string | null;
  schoolName: string | null;
  role: SchoolRole | null;
  mustChangePassword: boolean;
  needsConsent: boolean;
  /** true bila claims baru saja diperbarui; aplikasi perlu me-refresh ID token. */
  claimsUpdated: boolean;
}

/**
 * Dipanggil aplikasi setiap kali pengguna masuk. Idempoten: membuat profil
 * bila belum ada (termasuk akun lama sebelum MANDU 2.0), menerapkan undangan
 * staf, dan memastikan custom claims sesuai data Firestore.
 */
export async function syncAccount(caller: Caller): Promise<AccountSummary> {
  const record = await auth().getUser(caller.uid);
  if (isGuestRecord(record)) {
    throw new AppError("failed-precondition", "Akun tamu tidak memiliki profil.");
  }

  await ensureUserDoc(record);
  const ref = userRef(caller.uid);
  let user = (await ref.get()).data() as UserDoc;

  if (user.status !== "active" && user.status !== "pending" && user.email && record.emailVerified) {
    if (await acceptPendingInvitation(caller.uid, user.email)) {
      user = (await ref.get()).data() as UserDoc;
    }
  }

  const member = user.schoolId ? (await memberRef(user.schoolId, caller.uid).get()).data() as MemberDoc | undefined : undefined;
  let claimsUpdated = false;
  if (!claimsEqual(caller.claims, computeClaims(user, member))) {
    await syncClaims(caller.uid);
    claimsUpdated = true;
    user = (await ref.get()).data() as UserDoc;
  }

  return {
    uid: caller.uid,
    displayName: user.displayName,
    email: user.email,
    isSuperadmin: user.isSuperadmin,
    status: user.status,
    schoolId: user.schoolId,
    schoolName: user.schoolName,
    role: user.role,
    mustChangePassword: user.mustChangePassword,
    needsConsent: user.consentVersion !== CONSENT_VERSION,
    claimsUpdated,
  };
}
