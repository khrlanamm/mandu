import type {UserRecord} from "firebase-admin/auth";
import {FieldValue} from "firebase-admin/firestore";
import {db} from "../core/firebase";
import {normalizeEmail} from "../core/ids";
import {userRef} from "../core/refs";
import type {UserDoc} from "../domain/models";

export function newUserDoc(record: UserRecord, overrides: Partial<UserDoc> = {}): UserDoc {
  const now = FieldValue.serverTimestamp();
  const email = record.email ? normalizeEmail(record.email) : null;
  return {
    uid: record.uid,
    displayName: record.displayName?.trim() || email?.split("@")[0] || "Pengguna MANDU",
    email,
    photoUrl: record.photoURL ?? null,
    isSuperadmin: false,
    schoolId: null,
    schoolName: null,
    role: null,
    status: "none",
    mustChangePassword: false,
    consentVersion: null,
    consentAt: null,
    claimsVersion: 0,
    createdAt: now,
    updatedAt: now,
    ...overrides,
  };
}

/** Buat users/{uid} bila belum ada; selaraskan email & foto dengan Firebase Auth. */
export async function ensureUserDoc(record: UserRecord): Promise<void> {
  const ref = userRef(record.uid);
  await db().runTransaction(async (tx) => {
    const snapshot = await tx.get(ref);
    if (!snapshot.exists) {
      tx.set(ref, newUserDoc(record));
      return;
    }
    const current = snapshot.data() as UserDoc;
    const email = record.email ? normalizeEmail(record.email) : null;
    const photoUrl = record.photoURL ?? current.photoUrl;
    if (email !== current.email || photoUrl !== current.photoUrl) {
      tx.update(ref, {email, photoUrl, updatedAt: FieldValue.serverTimestamp()});
    }
  });
}

/** Akun tamu (Firebase Anonymous Auth), hanya untuk aspirasi tanpa login. */
export const isGuestRecord = (record: UserRecord) =>
  record.providerData.length === 0 && !record.email && !record.phoneNumber;
