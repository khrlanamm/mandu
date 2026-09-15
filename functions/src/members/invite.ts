import type {UserRecord} from "firebase-admin/auth";
import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import {ensureUserDoc} from "../accounts/users";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {auth, db} from "../core/firebase";
import {isNisnEmail, normalizeEmail, randomPassword} from "../core/ids";
import {requireSchoolAdminOrSuperadmin} from "../core/permissions";
import {invitationsRef, schoolRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {InvitationDoc, SchoolDoc, UserDoc} from "../domain/models";
import {acceptPendingInvitation} from "./invitations";
import {assertUnitsExist} from "./manage";

const inviteSchema = z.object({
  schoolId: z.string().min(1),
  email: z.email("Email tidak valid.").transform(normalizeEmail),
  displayName: z.string().trim().min(2).max(60).optional(),
  role: z.enum(["admin", "pimpinan", "konselor", "petugas"]),
  units: z.array(z.string().min(1)).max(10).default([]),
  canVerify: z.boolean().default(false),
  /** Buatkan akun email/password untuk staf yang tidak memakai Google. */
  createAccount: z.boolean().default(false),
});

export interface InviteResult {
  invitationId: string;
  /** "activated" bila akun sudah ada dan langsung menjadi anggota. */
  status: "invited" | "activated";
  /** Tautan atur password untuk akun yang baru dibuat; bagikan ke staf secara pribadi. */
  passwordSetupLink: string | null;
}

async function findUserByEmail(email: string): Promise<UserRecord | null> {
  try {
    return await auth().getUserByEmail(email);
  } catch (error) {
    if ((error as {code?: string}).code === "auth/user-not-found") return null;
    throw error;
  }
}

/** Admin sekolah/superadmin mengundang staf. Peran aktif saat staf masuk dengan email tersebut. */
export async function inviteStaff(caller: Caller, data: unknown): Promise<InviteResult> {
  const input = parsePayload(inviteSchema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);
  if (isNisnEmail(input.email)) {
    throw new AppError("invalid-argument", "Gunakan email asli staf, bukan akun NISN.");
  }

  const school = (await schoolRef(input.schoolId).get()).data() as SchoolDoc | undefined;
  if (!school) throw new AppError("not-found", "Sekolah tidak ditemukan.");
  const units = [...new Set(input.units)];
  await assertUnitsExist(input.schoolId, units);

  let record = await findUserByEmail(input.email);
  if (record) {
    const user = (await userRef(record.uid).get()).data() as UserDoc | undefined;
    if (user?.status === "active" || user?.status === "pending") {
      throw new AppError(
        "already-exists",
        user.schoolId === input.schoolId ?
          "Pengguna ini sudah menjadi anggota sekolah. Ubah perannya dari daftar anggota." :
          "Pengguna ini sudah terdaftar di sekolah lain.",
      );
    }
  }

  const pending = await invitationsRef().where("email", "==", input.email).where("status", "==", "pending").get();
  if (pending.docs.some((doc) => doc.get("schoolId") !== input.schoolId)) {
    throw new AppError("already-exists", "Email ini sedang diundang oleh sekolah lain.");
  }

  const invitationRef = invitationsRef().doc();
  const invitation: InvitationDoc = {
    email: input.email,
    schoolId: input.schoolId,
    schoolName: school.name,
    role: input.role,
    units,
    canVerify: input.canVerify,
    displayName: input.displayName ?? null,
    status: "pending",
    invitedBy: caller.uid,
    createdAt: FieldValue.serverTimestamp(),
    acceptedBy: null,
    acceptedAt: null,
  };
  const batch = db().batch();
  pending.docs.forEach((doc) => batch.update(doc.ref, {status: "revoked"}));
  batch.set(invitationRef, invitation);
  await batch.commit();

  let passwordSetupLink: string | null = null;
  if (!record && input.createAccount) {
    record = await auth().createUser({
      email: input.email,
      emailVerified: true,
      displayName: input.displayName,
      password: randomPassword(24),
    });
    passwordSetupLink = await auth().generatePasswordResetLink(input.email);
  }

  let status: InviteResult["status"] = "invited";
  if (record?.emailVerified) {
    await ensureUserDoc(record);
    if (await acceptPendingInvitation(record.uid, input.email)) status = "activated";
  }
  return {invitationId: invitationRef.id, status, passwordSetupLink};
}

const revokeSchema = z.object({invitationId: z.string().min(1)});

export async function revokeInvitation(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {invitationId} = parsePayload(revokeSchema, data);
  const ref = invitationsRef().doc(invitationId);
  const invitation = (await ref.get()).data() as InvitationDoc | undefined;
  if (!invitation) throw new AppError("not-found", "Undangan tidak ditemukan.");
  requireSchoolAdminOrSuperadmin(caller, invitation.schoolId);
  if (invitation.status !== "pending") {
    throw new AppError("failed-precondition", "Undangan sudah diterima atau dibatalkan.");
  }
  await ref.update({status: "revoked"});
  return {ok: true};
}
