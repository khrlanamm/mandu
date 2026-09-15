import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import {syncClaims} from "../accounts/claims";
import {SCHOOL_ROLES, type Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {auth, db} from "../core/firebase";
import {requireSchoolAdminOrSuperadmin} from "../core/permissions";
import {memberRef, schoolRef, unitsRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {MemberDoc, UserDoc} from "../domain/models";

export async function assertUnitsExist(schoolId: string, units: readonly string[]): Promise<void> {
  if (units.length === 0) return;
  const snapshots = await db().getAll(...units.map((id) => unitsRef(schoolId).doc(id)));
  const missing = snapshots.filter((snapshot) => !snapshot.exists).map((snapshot) => snapshot.id);
  if (missing.length > 0) {
    throw new AppError("invalid-argument", `Unit tidak ditemukan: ${missing.join(", ")}.`);
  }
}

async function countActiveAdmins(schoolId: string): Promise<number> {
  const aggregate = await schoolRef(schoolId).collection("members")
    .where("role", "==", "admin")
    .where("status", "==", "active")
    .count()
    .get();
  return aggregate.data().count;
}

const updateSchema = z.object({
  schoolId: z.string().min(1),
  uid: z.string().min(1),
  role: z.enum(SCHOOL_ROLES).optional(),
  units: z.array(z.string().min(1)).max(10).optional(),
  canVerify: z.boolean().optional(),
  kelas: z.string().trim().max(20).nullable().optional(),
  displayName: z.string().trim().min(2).max(60).optional(),
});

/** Admin mengubah peran, unit, hak verifikasi, kelas, atau nama anggota aktif. */
export async function updateMember(caller: Caller, data: unknown): Promise<{ok: true}> {
  const input = parsePayload(updateSchema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);

  const ref = memberRef(input.schoolId, input.uid);
  const member = (await ref.get()).data() as MemberDoc | undefined;
  if (member?.status !== "active") {
    throw new AppError("not-found", "Anggota aktif tidak ditemukan.");
  }

  const role = input.role ?? member.role;
  const units = role === "siswa" ? [] : [...new Set(input.units ?? member.units)];
  await assertUnitsExist(input.schoolId, units);
  if (member.role === "admin" && role !== "admin" && (await countActiveAdmins(input.schoolId)) <= 1) {
    throw new AppError("failed-precondition", "Sekolah harus memiliki minimal satu admin aktif.");
  }

  const now = FieldValue.serverTimestamp();
  const memberUpdates: Record<string, unknown> = {
    role,
    units,
    canVerify: role === "siswa" ? false : input.canVerify ?? member.canVerify,
    updatedAt: now,
  };
  const userUpdates: Record<string, unknown> = {role, updatedAt: now};
  if (input.kelas !== undefined) memberUpdates.kelas = input.kelas;
  if (input.displayName) {
    memberUpdates.displayName = input.displayName;
    userUpdates.displayName = input.displayName;
  }

  const batch = db().batch();
  batch.update(ref, memberUpdates);
  batch.update(userRef(input.uid), userUpdates);
  await batch.commit();

  await syncClaims(input.uid);
  return {ok: true};
}

const removeSchema = z.object({schoolId: z.string().min(1), uid: z.string().min(1)});

/**
 * Keluarkan anggota dari sekolah. Akun NISN dinonaktifkan karena terikat
 * pada sekolah; akun Google bisa bergabung ke sekolah lain.
 */
export async function removeMember(caller: Caller, data: unknown): Promise<{ok: true}> {
  const input = parsePayload(removeSchema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);

  const ref = memberRef(input.schoolId, input.uid);
  const member = (await ref.get()).data() as MemberDoc | undefined;
  if (!member || (member.status !== "active" && member.status !== "pending")) {
    throw new AppError("not-found", "Anggota tidak ditemukan.");
  }
  if (member.role === "admin" && member.status === "active" && (await countActiveAdmins(input.schoolId)) <= 1) {
    throw new AppError("failed-precondition", "Sekolah harus memiliki minimal satu admin aktif.");
  }

  await db().runTransaction(async (tx) => {
    const userSnap = await tx.get(userRef(input.uid));
    const now = FieldValue.serverTimestamp();
    tx.update(ref, {status: "removed", updatedAt: now});
    if ((userSnap.data() as UserDoc | undefined)?.schoolId === input.schoolId) {
      tx.update(userSnap.ref, {schoolId: null, schoolName: null, role: null, status: "removed", updatedAt: now});
    }
  });

  await syncClaims(input.uid);
  if (member.joinedVia === "nisn") await auth().updateUser(input.uid, {disabled: true});
  await auth().revokeRefreshTokens(input.uid);
  return {ok: true};
}
