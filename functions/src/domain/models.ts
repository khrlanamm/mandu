import type {FieldValue, Timestamp} from "firebase-admin/firestore";
import type {SchoolRole} from "../core/claims";

export type Time = Timestamp | FieldValue;

export type MemberStatus = "pending" | "active" | "rejected" | "removed";
export type AccountStatus = "none" | MemberStatus;
export type JoinMethod = "code" | "domain" | "nisn" | "invite" | "migration";
export type StaffRole = Exclude<SchoolRole, "siswa">;

export interface ServiceToggles {
  lapor: boolean;
  curhat: boolean;
  aspirasi: boolean;
  bantuan: boolean;
  edukasi: boolean;
}

export interface SlaHours {
  verifikasi: number;
  tindakLanjut: number;
  darurat: number;
}

/** schools/{schoolId} */
export interface SchoolDoc {
  name: string;
  code: string;
  npsn: string | null;
  level: string;
  address: string | null;
  city: string;
  province: string;
  logoUrl: string | null;
  /** Domain email sekolah yang siswanya disetujui otomatis saat bergabung. */
  allowedDomains: string[];
  active: boolean;
  services: ServiceToggles;
  /** Aspirasi boleh dikirim tanpa login lewat kode/QR sekolah. */
  publicAspiration: boolean;
  /** Papan aspirasi untuk siswa sekolah ini. */
  aspirationBoard: boolean;
  slaHours: SlaHours;
  createdBy: string;
  createdAt: Time;
  updatedAt: Time;
}

/** schools/{schoolId}/members/{uid} */
export interface MemberDoc {
  uid: string;
  displayName: string;
  email: string | null;
  role: SchoolRole;
  units: string[];
  canVerify: boolean;
  status: MemberStatus;
  joinedVia: JoinMethod;
  kelas: string | null;
  nisn: string | null;
  reviewedBy: string | null;
  reviewedAt: Time | null;
  rejectionReason: string | null;
  createdAt: Time;
  updatedAt: Time;
}

/** users/{uid} — hanya ditulis Cloud Functions. */
export interface UserDoc {
  uid: string;
  displayName: string;
  email: string | null;
  photoUrl: string | null;
  isSuperadmin: boolean;
  schoolId: string | null;
  schoolName: string | null;
  role: SchoolRole | null;
  status: AccountStatus;
  /** Akun NISN wajib mengganti password awal. */
  mustChangePassword: boolean;
  consentVersion: string | null;
  consentAt: Time | null;
  /** Naik setiap custom claims berubah; aplikasi me-refresh ID token. */
  claimsVersion: number;
  createdAt: Time;
  updatedAt: Time;
}

/** invitations/{id} */
export interface InvitationDoc {
  email: string;
  schoolId: string;
  schoolName: string;
  role: StaffRole;
  units: string[];
  canVerify: boolean;
  displayName: string | null;
  status: "pending" | "accepted" | "revoked";
  invitedBy: string;
  createdAt: Time;
  acceptedBy: string | null;
  acceptedAt: Time | null;
}

/** schoolCodes/{code} */
export interface SchoolCodeDoc {
  schoolId: string;
  createdAt: Time;
}

/** schools/{schoolId}/units/{unitId} */
export interface UnitDoc {
  name: string;
  description: string;
  categories: string[];
  active: boolean;
  createdAt: Time;
  updatedAt: Time;
}
