import type {Timestamp} from "firebase-admin/firestore";
import type {SchoolRole} from "../core/claims";
import type {Priority} from "./catalog";
import type {Time} from "./models";

export const TICKET_STATUSES = [
  "menunggu_verifikasi",
  "perlu_dilengkapi",
  "diteruskan",
  "diproses",
  "selesai",
  "ditolak",
  "dibatalkan",
] as const;
export type TicketStatus = (typeof TICKET_STATUSES)[number];

export const REJECT_REASONS = ["duplikat", "tidak_valid", "bukan_wewenang", "lainnya"] as const;
export type RejectReason = (typeof REJECT_REASONS)[number];

export const REJECT_REASON_LABELS: Record<RejectReason, string> = {
  duplikat: "sama dengan laporan lain",
  tidak_valid: "data tidak dapat diverifikasi",
  bukan_wewenang: "bukan wewenang sekolah",
  lainnya: "alasan lain",
};

export const MAX_ATTACHMENTS = 5;
export const MAX_TICKET_ATTACHMENTS = 10;
export const MAX_ATTACHMENT_BYTES = 10 * 1024 * 1024;

export interface Attachment {
  path: string;
  name: string;
  contentType: string;
  size: number;
}

/** schools/{schoolId}/tickets/{ticketId} — identitas pelapor tidak disimpan di sini. */
export interface TicketDoc {
  number: string;
  schoolId: string;
  category: string;
  categoryLabel: string;
  subcategory: string;
  subcategoryLabel: string;
  title: string;
  description: string;
  location: string;
  incidentDate: string | null;
  incidentTime: string | null;
  details: {role: "korban" | "saksi" | null; frequency: string | null; involved: string | null};
  attachments: Attachment[];
  anonymous: boolean;
  /** null bila pelapor merahasiakan identitas. */
  reporter: {name: string; kelas: string | null} | null;
  contactWhatsapp: string | null;
  priority: Priority;
  priorityReason: string | null;
  suggestedCategory: string | null;
  possibleDuplicateOf: string | null;
  status: TicketStatus;
  unitId: string | null;
  unitName: string | null;
  infoRequest: {message: string; requestedAt: Time} | null;
  resolution: {note: string; attachments: Attachment[]; resolvedByName: string; resolvedAt: Time} | null;
  rejection: {reason: RejectReason; note: string | null} | null;
  rating: {score: number; comment: string | null; ratedAt: Time} | null;
  sla: {verifyDueAt: Timestamp; resolveDueAt: Timestamp | null};
  reminders: {verify: boolean; resolve: boolean};
  createdAt: Time;
  updatedAt: Time;
  verifiedAt: Time | null;
  resolvedAt: Time | null;
  closedAt: Time | null;
}

export type TimelineType =
  | "dibuat"
  | "diminta_melengkapi"
  | "dilengkapi"
  | "diteruskan"
  | "dialihkan"
  | "progres"
  | "catatan_internal"
  | "selesai"
  | "ditolak"
  | "dibatalkan"
  | "dinilai"
  | "pengingat";

/** schools/{schoolId}/tickets/{ticketId}/timeline/{eventId} */
export interface TimelineDoc {
  type: TimelineType;
  visibility: "public" | "internal";
  message: string | null;
  actorRole: SchoolRole | "pelapor" | "sistem";
  actorName: string | null;
  attachments: Attachment[];
  createdAt: Time;
}

/** schools/{schoolId}/ticketOwners/{ticketId} — hanya bisa dibaca pelapor. */
export interface TicketOwnerDoc {
  uid: string;
  anonymous: boolean;
  createdAt: Time;
}

export const studentTicketRoute = (ticketId: string) => `/home/laporan/${ticketId}`;
export const staffTicketRoute = (ticketId: string) => `/staff/laporan/${ticketId}`;
