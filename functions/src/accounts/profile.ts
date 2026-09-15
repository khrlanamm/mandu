import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {auth} from "../core/firebase";
import {isNisnEmail} from "../core/ids";
import {memberRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {CONSENT_VERSION} from "../domain/catalog";
import type {MemberDoc, UserDoc} from "../domain/models";

async function requireUser(uid: string): Promise<UserDoc> {
  const user = (await userRef(uid).get()).data() as UserDoc | undefined;
  if (!user) throw new AppError("failed-precondition", "Profil belum dibuat. Muat ulang aplikasi.");
  return user;
}

/** Persetujuan kebijakan privasi & ketentuan layanan. */
export async function acceptConsent(caller: Caller, data: unknown): Promise<{consentVersion: string}> {
  const {version} = parsePayload(z.object({version: z.string()}), data);
  if (version !== CONSENT_VERSION) {
    throw new AppError("failed-precondition", "Versi kebijakan privasi sudah berubah. Muat ulang aplikasi.");
  }
  await requireUser(caller.uid);
  await userRef(caller.uid).update({consentVersion: version, consentAt: FieldValue.serverTimestamp(), updatedAt: FieldValue.serverTimestamp()});
  return {consentVersion: version};
}

const passwordSchema = z.object({
  newPassword: z.string().min(8, "Password minimal 8 karakter.").max(128),
});

/**
 * Akun NISN mengganti password awal dari admin. Setelah berhasil, aplikasi
 * masuk ulang dengan password baru.
 */
export async function changeInitialPassword(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {newPassword} = parsePayload(passwordSchema, data);
  const user = await requireUser(caller.uid);
  if (!isNisnEmail(user.email)) {
    throw new AppError("failed-precondition", "Hanya akun NISN yang mengganti password lewat MANDU.");
  }
  if (user.schoolId) {
    const member = (await memberRef(user.schoolId, caller.uid).get()).data() as MemberDoc | undefined;
    if (member?.nisn && newPassword.includes(member.nisn)) {
      throw new AppError("invalid-argument", "Password tidak boleh memuat NISN.");
    }
  }
  await auth().updateUser(caller.uid, {password: newPassword});
  await userRef(caller.uid).update({mustChangePassword: false, updatedAt: FieldValue.serverTimestamp()});
  return {ok: true};
}

const nameSchema = z.object({displayName: z.string().trim().min(2).max(60)});

/** Ubah nama tampilan (juga di keanggotaan sekolah). */
export async function updateDisplayName(caller: Caller, data: unknown): Promise<{displayName: string}> {
  const {displayName} = parsePayload(nameSchema, data);
  const user = await requireUser(caller.uid);
  const now = FieldValue.serverTimestamp();
  await userRef(caller.uid).update({displayName, updatedAt: now});
  if (user.schoolId) {
    const ref = memberRef(user.schoolId, caller.uid);
    if ((await ref.get()).exists) await ref.update({displayName, updatedAt: now});
  }
  await auth().updateUser(caller.uid, {displayName});
  return {displayName};
}
