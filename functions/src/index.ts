import {setGlobalOptions} from "firebase-functions/v2";
import {onSchedule} from "firebase-functions/v2/scheduler";
import {acceptConsent, changeInitialPassword, updateDisplayName} from "./accounts/profile";
import {syncAccount} from "./accounts/sync";
import {reviewAspiration, supportAspiration} from "./aspirations/review";
import {optionalCaller, submitAspiration, submitPublicAspiration} from "./aspirations/submit";
import {callable} from "./core/callable";
import {requireAuth, requireSuperadmin} from "./core/claims";
import {inviteStaff, revokeInvitation} from "./members/invite";
import {cancelJoin, joinSchool} from "./members/join";
import {removeMember, updateMember} from "./members/manage";
import {reviewMembers} from "./members/review";
import {importStudents, resetStudentPassword} from "./members/students";
import {registerDevice, unregisterDevice} from "./notifications/notify";
import {lookupSchool} from "./schools/lookup";
import {changeSchoolCode, createSchool, updateSchool} from "./schools/manage";
import {runSlaReminders} from "./tickets/reminders";
import {submitTicket} from "./tickets/submit";
import {
  addTicketProgress,
  cancelTicket,
  rateTicket,
  reassignTicket,
  resolveTicket,
  supplyTicketInfo,
  verifyTicket,
} from "./tickets/workflow";

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
  registerDevice: callable("account-registerDevice", (request) => registerDevice(requireAuth(request), request.data)),
  unregisterDevice: callable("account-unregisterDevice", (request) => unregisterDevice(requireAuth(request), request.data)),
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

/** Layanan Lapor: `tickets-submit`, `tickets-verify`, ... */
export const tickets = {
  submit: callable("tickets-submit", (request) => submitTicket(requireAuth(request), request.data)),
  verify: callable("tickets-verify", (request) => verifyTicket(requireAuth(request), request.data)),
  supplyInfo: callable("tickets-supplyInfo", (request) => supplyTicketInfo(requireAuth(request), request.data)),
  cancel: callable("tickets-cancel", (request) => cancelTicket(requireAuth(request), request.data)),
  addProgress: callable("tickets-addProgress", (request) => addTicketProgress(requireAuth(request), request.data)),
  resolve: callable("tickets-resolve", (request) => resolveTicket(requireAuth(request), request.data)),
  reassign: callable("tickets-reassign", (request) => reassignTicket(requireAuth(request), request.data)),
  rate: callable("tickets-rate", (request) => rateTicket(requireAuth(request), request.data)),
};

/** Aspirasi siswa & tamu: `aspirations-submit`, `aspirations-submitPublic`, ... */
export const aspirations = {
  submit: callable("aspirations-submit", (request) => submitAspiration(requireAuth(request), request.data)),
  // Tanpa login (tamu lewat kode/QR sekolah); dibatasi per IP dan per akun anonim.
  submitPublic: callable("aspirations-submitPublic", (request) =>
    submitPublicAspiration(optionalCaller(request), request.data, request.rawRequest.ip)),
  review: callable("aspirations-review", (request) => reviewAspiration(requireAuth(request), request.data)),
  support: callable("aspirations-support", (request) => supportAspiration(requireAuth(request), request.data)),
};

/** Pengingat laporan yang melewati batas waktu verifikasi/tindak lanjut. */
export const slaReminders = onSchedule({schedule: "every 60 minutes", timeZone: "Asia/Jakarta"}, async () => {
  await runSlaReminders();
});

// Dipakai aplikasi 4.0.0 sampai migrasi MANDU 2.0 selesai (lihat rencana tahap 7).
export {sendReportNotification} from "./legacy/sendReportNotification";
