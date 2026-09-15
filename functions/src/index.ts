import {setGlobalOptions} from "firebase-functions/v2";
import {changeInitialPassword, acceptConsent, updateDisplayName} from "./accounts/profile";
import {syncAccount} from "./accounts/sync";
import {callable} from "./core/callable";
import {requireAuth, requireSuperadmin} from "./core/claims";
import {inviteStaff, revokeInvitation} from "./members/invite";
import {cancelJoin, joinSchool} from "./members/join";
import {removeMember, updateMember} from "./members/manage";
import {reviewMembers} from "./members/review";
import {importStudents, resetStudentPassword} from "./members/students";
import {lookupSchool} from "./schools/lookup";
import {changeSchoolCode, createSchool, updateSchool} from "./schools/manage";

setGlobalOptions({region: "us-central1", maxInstances: 10});

/** Profil & akun pengguna: `account-sync`, `account-acceptConsent`, ... */
export const account = {
  sync: callable("account-sync", (request) => syncAccount(requireAuth(request))),
  acceptConsent: callable("account-acceptConsent", (request) => acceptConsent(requireAuth(request), request.data)),
  changeInitialPassword: callable(
    "account-changeInitialPassword",
    (request) => changeInitialPassword(requireAuth(request), request.data),
  ),
  updateDisplayName: callable("account-updateDisplayName", (request) => updateDisplayName(requireAuth(request), request.data)),
};

export const schools = {
  /** Publik: dipakai halaman gabung sekolah, login NISN, dan aspirasi tanpa login. */
  lookup: callable("schools-lookup", (request) => lookupSchool(request.data)),
  create: callable("schools-create", (request) => createSchool(requireSuperadmin(request), request.data)),
  update: callable("schools-update", (request) => updateSchool(requireAuth(request), request.data)),
  changeCode: callable("schools-changeCode", (request) => changeSchoolCode(requireAuth(request), request.data)),
};

export const members = {
  join: callable("members-join", (request) => joinSchool(requireAuth(request), request.data)),
  cancelJoin: callable("members-cancelJoin", (request) => cancelJoin(requireAuth(request))),
  review: callable("members-review", (request) => reviewMembers(requireAuth(request), request.data)),
  update: callable("members-update", (request) => updateMember(requireAuth(request), request.data)),
  remove: callable("members-remove", (request) => removeMember(requireAuth(request), request.data)),
  invite: callable("members-invite", (request) => inviteStaff(requireAuth(request), request.data)),
  revokeInvitation: callable("members-revokeInvitation", (request) => revokeInvitation(requireAuth(request), request.data)),
  importStudents: callable(
    "members-importStudents",
    (request) => importStudents(requireAuth(request), request.data),
    {timeoutSeconds: 300, memory: "512MiB"},
  ),
  resetStudentPassword: callable(
    "members-resetStudentPassword",
    (request) => resetStudentPassword(requireAuth(request), request.data),
  ),
};

// Dipakai aplikasi 4.0.0 sampai migrasi MANDU 2.0 selesai (lihat rencana tahap 7).
export {sendReportNotification} from "./legacy/sendReportNotification";
