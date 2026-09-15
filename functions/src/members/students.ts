import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import {syncClaims} from "../accounts/claims";
import {newUserDoc} from "../accounts/users";
import {mapWithConcurrency} from "../core/async";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {auth, db} from "../core/firebase";
import {NISN_PATTERN, nisnEmail, randomPassword} from "../core/ids";
import {requireSchoolAdminOrSuperadmin} from "../core/permissions";
import {memberRef, schoolRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {MemberDoc, SchoolDoc} from "../domain/models";

const studentSchema = z.object({
  nisn: z.string().trim().regex(NISN_PATTERN, "NISN/NIS hanya berisi angka."),
  name: z.string().trim().min(2).max(60),
  kelas: z.string().trim().min(1).max(20),
});

const importSchema = z.object({
  schoolId: z.string().min(1),
  students: z.array(studentSchema).min(1).max(300),
});

export type ImportStatus = "created" | "exists" | "duplicate" | "error";

export interface ImportRow {
  nisn: string;
  name: string;
  kelas: string;
  status: ImportStatus;
  /** Password awal; hanya dikembalikan sekali saat akun dibuat. */
  password: string | null;
  message: string | null;
}

async function nisnTaken(schoolId: string, nisn: string): Promise<boolean> {
  const snapshot = await schoolRef(schoolId).collection("members")
    .where("nisn", "==", nisn)
    .where("status", "in", ["active", "pending"])
    .limit(1)
    .get();
  return !snapshot.empty;
}

async function importOne(
  caller: Caller,
  schoolId: string,
  schoolName: string,
  student: z.infer<typeof studentSchema>,
): Promise<ImportRow> {
  const row: ImportRow = {...student, status: "error", password: null, message: null};
  if (await nisnTaken(schoolId, student.nisn)) {
    return {...row, status: "duplicate", message: "NISN sudah terdaftar di sekolah ini."};
  }

  const password = randomPassword();
  let uid: string;
  try {
    const record = await auth().createUser({
      email: nisnEmail(schoolId, student.nisn),
      emailVerified: true,
      displayName: student.name,
      password,
    });
    uid = record.uid;

    const now = FieldValue.serverTimestamp();
    const member: MemberDoc = {
      uid,
      displayName: student.name,
      email: record.email ?? null,
      role: "siswa",
      units: [],
      canVerify: false,
      status: "active",
      joinedVia: "nisn",
      kelas: student.kelas,
      nisn: student.nisn,
      reviewedBy: caller.uid,
      reviewedAt: now,
      rejectionReason: null,
      createdAt: now,
      updatedAt: now,
    };
    const batch = db().batch();
    batch.set(userRef(uid), newUserDoc(record, {
      displayName: student.name,
      schoolId,
      schoolName,
      role: "siswa",
      status: "active",
      mustChangePassword: true,
    }));
    batch.set(memberRef(schoolId, uid), member);
    try {
      await batch.commit();
    } catch (error) {
      await auth().deleteUser(uid);
      throw error;
    }
  } catch (error) {
    if ((error as {code?: string}).code === "auth/email-already-exists") {
      return {...row, status: "exists", message: "Akun NISN ini sudah ada."};
    }
    return {...row, message: "Gagal membuat akun. Coba impor ulang baris ini."};
  }

  await syncClaims(uid);
  return {...row, status: "created", password};
}

/** Admin mengimpor akun siswa berbasis NISN. Password awal hanya ditampilkan sekali. */
export async function importStudents(caller: Caller, data: unknown): Promise<{results: ImportRow[]; created: number}> {
  const input = parsePayload(importSchema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);
  const school = (await schoolRef(input.schoolId).get()).data() as SchoolDoc | undefined;
  if (!school) throw new AppError("not-found", "Sekolah tidak ditemukan.");

  const seen = new Set<string>();
  const results = await mapWithConcurrency(input.students, 5, async (student) => {
    if (seen.has(student.nisn)) {
      return {...student, status: "duplicate" as const, password: null, message: "NISN muncul lebih dari sekali di berkas."};
    }
    seen.add(student.nisn);
    return importOne(caller, input.schoolId, school.name, student);
  });
  return {results, created: results.filter((row) => row.status === "created").length};
}

const resetSchema = z.object({schoolId: z.string().min(1), uid: z.string().min(1)});

/** Admin membuat password awal baru untuk siswa NISN yang lupa password. */
export async function resetStudentPassword(caller: Caller, data: unknown): Promise<{password: string}> {
  const input = parsePayload(resetSchema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);

  const member = (await memberRef(input.schoolId, input.uid).get()).data() as MemberDoc | undefined;
  if (member?.status !== "active" || member.joinedVia !== "nisn") {
    throw new AppError("failed-precondition", "Reset password hanya untuk akun NISN yang aktif.");
  }

  const password = randomPassword();
  await auth().updateUser(input.uid, {password, disabled: false});
  await auth().revokeRefreshTokens(input.uid);
  await userRef(input.uid).update({mustChangePassword: true, updatedAt: FieldValue.serverTimestamp()});
  return {password};
}
