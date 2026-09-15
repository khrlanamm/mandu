import {FieldValue} from "firebase-admin/firestore";
import {db} from "../core/firebase";
import {normalizeEmail} from "../core/ids";
import {invitationsRef, memberRef, userRef} from "../core/refs";
import {syncClaims} from "../accounts/claims";
import type {InvitationDoc, MemberDoc, UserDoc} from "../domain/models";

/**
 * Aktifkan undangan staf untuk email terverifikasi. Pengguna yang sudah
 * terikat/menunggu di sebuah sekolah tidak dipindahkan.
 */
export async function acceptPendingInvitation(uid: string, email: string): Promise<boolean> {
  const snapshot = await invitationsRef()
    .where("email", "==", normalizeEmail(email))
    .where("status", "==", "pending")
    .limit(1)
    .get();
  if (snapshot.empty) return false;

  const invitationRef = snapshot.docs[0].ref;
  const accepted = await db().runTransaction(async (tx) => {
    const [invitationSnap, userSnap] = await Promise.all([tx.get(invitationRef), tx.get(userRef(uid))]);
    const invitation = invitationSnap.data() as InvitationDoc | undefined;
    const user = userSnap.data() as UserDoc | undefined;
    if (!invitation || invitation.status !== "pending" || !user) return false;
    if (user.status === "active" || user.status === "pending") return false;

    const now = FieldValue.serverTimestamp();
    const member: MemberDoc = {
      uid,
      displayName: invitation.displayName ?? user.displayName,
      email: user.email,
      role: invitation.role,
      units: invitation.units,
      canVerify: invitation.canVerify,
      status: "active",
      joinedVia: "invite",
      kelas: null,
      nisn: null,
      reviewedBy: invitation.invitedBy,
      reviewedAt: now,
      rejectionReason: null,
      createdAt: now,
      updatedAt: now,
    };
    tx.set(memberRef(invitation.schoolId, uid), member);
    tx.update(userRef(uid), {
      schoolId: invitation.schoolId,
      schoolName: invitation.schoolName,
      role: invitation.role,
      status: "active",
      updatedAt: now,
    });
    tx.update(invitationRef, {status: "accepted", acceptedBy: uid, acceptedAt: now});
    return true;
  });

  if (accepted) await syncClaims(uid);
  return accepted;
}
