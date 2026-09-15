import type {Caller} from "./claims";
import {AppError} from "./errors";

export const isSchoolAdmin = (caller: Caller, schoolId: string) =>
  caller.claims.sid === schoolId && caller.claims.role === "admin";

export function requireSchoolAdminOrSuperadmin(caller: Caller, schoolId: string): void {
  if (!caller.claims.sa && !isSchoolAdmin(caller, schoolId)) {
    throw new AppError("permission-denied", "Hanya admin sekolah atau superadmin yang dapat melakukan ini.");
  }
}
