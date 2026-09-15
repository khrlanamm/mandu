import type {CallableRequest} from "firebase-functions/v2/https";
import {AppError} from "./errors";

export const SCHOOL_ROLES = ["admin", "pimpinan", "konselor", "petugas", "siswa"] as const;
export type SchoolRole = (typeof SCHOOL_ROLES)[number];

/** Custom claims MANDU. Hanya diset oleh Cloud Functions. */
export interface ManduClaims {
  /** Superadmin platform. */
  sa?: boolean;
  /** ID sekolah tempat pengguna menjadi anggota aktif. */
  sid?: string;
  role?: SchoolRole;
  /** Unit yang ditangani petugas. */
  units?: string[];
  /** Anggota Tim Verifikasi. */
  canVerify?: boolean;
}

export interface Caller {
  uid: string;
  claims: ManduClaims;
}

export function readClaims(token: Record<string, unknown>): ManduClaims {
  const role = typeof token.role === "string" && (SCHOOL_ROLES as readonly string[]).includes(token.role) ?
    (token.role as SchoolRole) :
    undefined;
  return {
    sa: token.sa === true,
    sid: typeof token.sid === "string" ? token.sid : undefined,
    role,
    units: Array.isArray(token.units) ? token.units.filter((unit): unit is string => typeof unit === "string") : [],
    canVerify: token.canVerify === true,
  };
}

export function requireAuth(request: CallableRequest): Caller {
  if (!request.auth) {
    throw new AppError("unauthenticated", "Silakan masuk terlebih dahulu.");
  }
  return {uid: request.auth.uid, claims: readClaims(request.auth.token)};
}

export function requireSuperadmin(request: CallableRequest): Caller {
  const caller = requireAuth(request);
  if (!caller.claims.sa) {
    throw new AppError("permission-denied", "Hanya superadmin yang dapat melakukan ini.");
  }
  return caller;
}

/** Pemanggil harus anggota aktif sekolah [schoolId] dengan salah satu [roles]. */
export function requireSchoolRole(request: CallableRequest, schoolId: string, roles: readonly SchoolRole[]): Caller {
  const caller = requireAuth(request);
  const {sid, role} = caller.claims;
  if (sid !== schoolId || !role || !roles.includes(role)) {
    throw new AppError("permission-denied", "Anda tidak memiliki akses untuk tindakan ini.");
  }
  return caller;
}
