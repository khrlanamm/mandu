import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import {syncClaims} from "../accounts/claims";
import {isGuestRecord} from "../accounts/users";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {auth, db} from "../core/firebase";
import {emailDomain, isNisnEmail, NISN_PATTERN, normalizeEmail, SCHOOL_CODE_PATTERN} from "../core/ids";
import {memberRef, schoolCodeRef, schoolRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {MemberDoc, SchoolCodeDoc, SchoolDoc, UserDoc} from "../domain/models";

const joinSchema = z.object({
  code: z.string().trim().toUpperCase().regex(SCHOOL_CODE_PATTERN, "Kode sekolah tidak valid."),
  displayName: z.string().trim().min(2).max(60),
  kelas: z.string().trim().min(1).max(20),
  nisn: z.string().trim().regex(NISN_PATTERN, "NISN/NIS hanya berisi angka.").optional(),
});

export interface JoinResult {
  status: "pending" | "active";
  schoolId: string;
  schoolName: string;
}

/** Siswa dengan akun Google bergabung ke sekolah memakai kode sekolah. */
export async function joinSchool(caller: Caller, data: unknown): Promise<JoinResult> {
  const input = parsePayload(joinSchema, data);
  const record = await auth().getUser(caller.uid);
  if (isGuestRecord(record)) {
    throw new AppError("permission-denied", "Masuk dengan akun Google terlebih dahulu untuk bergabung ke sekolah.");
  }
  if (isNisnEmail(record.email)) {
    throw new AppError("failed-precondition", "Akun NISN sudah terdaftar di sekolahnya.");
  }

  const codeDoc = (await schoolCodeRef(input.code).get()).data() as SchoolCodeDoc | undefined;
  const school = codeDoc ? (await schoolRef(codeDoc.schoolId).get()).data() as SchoolDoc | undefined : undefined;
  if (!codeDoc || !school || !school.active) {
    throw new AppError("not-found", "Kode sekolah tidak ditemukan. Periksa kembali kode dari sekolahmu.");
  }
  const schoolId = codeDoc.schoolId;

  const email = record.email ? normalizeEmail(record.email) : null;
  const autoApprove = email !== null && record.emailVerified && school.allowedDomains.includes(emailDomain(email));
  const status: JoinResult["status"] = autoApprove ? "active" : "pending";

  await db().runTransaction(async (tx) => {
    const user = (await tx.get(userRef(caller.uid))).data() as UserDoc | undefined;
    if (!user) {
      throw new AppError("failed-precondition", "Profil belum siap. Muat ulang aplikasi lalu coba lagi.");
    }
    if (user.status === "active") {
      throw new AppError("failed-precondition", `Anda sudah terdaftar di ${user.schoolName}.`);
    }
    if (user.status === "pending") {
      throw new AppError("failed-precondition", `Permintaan bergabung ke ${user.schoolName} masih menunggu persetujuan.`);
    }
    if (input.nisn) {
      const duplicate = await tx.get(
        schoolRef(schoolId).collection("members")
          .where("nisn", "==", input.nisn)
          .where("status", "in", ["active", "pending"])
          .limit(1),
      );
      if (!duplicate.empty) {
        throw new AppError("already-exists", "NISN ini sudah terdaftar di sekolah tersebut. Hubungi admin sekolah.");
      }
    }

    const now = FieldValue.serverTimestamp();
    const member: MemberDoc = {
      uid: caller.uid,
      displayName: input.displayName,
      email,
      role: "siswa",
      units: [],
      canVerify: false,
      status,
      joinedVia: autoApprove ? "domain" : "code",
      kelas: input.kelas,
      nisn: input.nisn ?? null,
      reviewedBy: null,
      reviewedAt: autoApprove ? now : null,
      rejectionReason: null,
      createdAt: now,
      updatedAt: now,
    };
    tx.set(memberRef(schoolId, caller.uid), member);
    tx.update(userRef(caller.uid), {
      displayName: input.displayName,
      schoolId,
      schoolName: school.name,
      role: "siswa",
      status,
      updatedAt: now,
    });
  });

  if (autoApprove) await syncClaims(caller.uid);
  return {status, schoolId, schoolName: school.name};
}

/** Batalkan permintaan bergabung yang masih menunggu (mis. salah memasukkan kode). */
export async function cancelJoin(caller: Caller): Promise<{ok: true}> {
  await db().runTransaction(async (tx) => {
    const user = (await tx.get(userRef(caller.uid))).data() as UserDoc | undefined;
    if (!user || user.status !== "pending" || !user.schoolId) {
      throw new AppError("failed-precondition", "Tidak ada permintaan bergabung yang menunggu.");
    }
    tx.delete(memberRef(user.schoolId, caller.uid));
    tx.update(userRef(caller.uid), {
      schoolId: null,
      schoolName: null,
      role: null,
      status: "none",
      updatedAt: FieldValue.serverTimestamp(),
    });
  });
  return {ok: true};
}
