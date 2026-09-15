import type {Timestamp} from "firebase-admin/firestore";
import type {Time} from "./models";

/** Butuh Bantuan & Curhat. Salin label ke lib/features/care/domain bila berubah. */

export const HELP_NEEDS = [
  {key: "ingin_bicara", label: "Ingin bicara dengan seseorang"},
  {key: "tidak_aman", label: "Merasa tidak aman"},
  {key: "keluarga", label: "Masalah keluarga"},
  {key: "teman", label: "Masalah pertemanan"},
  {key: "belajar", label: "Tekanan belajar"},
  {key: "perasaan", label: "Sedih, cemas, atau kewalahan"},
  {key: "belum_siap", label: "Belum siap cerita"},
] as const;
export const HELP_NEED_KEYS = HELP_NEEDS.map((need) => need.key);

export const HELP_URGENCIES = ["biasa", "segera", "darurat"] as const;
export type HelpUrgency = (typeof HELP_URGENCIES)[number];
export const HELP_URGENCY_LABELS: Record<HelpUrgency, string> = {
  biasa: "Bisa menunggu",
  segera: "Hari ini",
  darurat: "Sekarang juga",
};

export const CONTACT_METHODS = ["chat", "bertemu", "whatsapp"] as const;
export type ContactMethod = (typeof CONTACT_METHODS)[number];

export const CONTACT_TIMES = ["istirahat", "pulang_sekolah", "kapan_saja"] as const;

export const HELP_STATUSES = ["menunggu", "ditangani", "selesai", "dibatalkan"] as const;
export type HelpStatus = (typeof HELP_STATUSES)[number];

/** schools/{schoolId}/helpRequests/{id} — dibaca siswa pemilik dan konselor sekolah. */
export interface HelpRequestDoc {
  number: string;
  schoolId: string;
  studentUid: string;
  student: {name: string; kelas: string | null};
  needs: string[];
  urgency: HelpUrgency;
  contactMethod: ContactMethod;
  contactTime: (typeof CONTACT_TIMES)[number];
  whatsapp: string | null;
  note: string | null;
  status: HelpStatus;
  counselorUid: string | null;
  counselorName: string | null;
  conversationId: string | null;
  closingNote: string | null;
  createdAt: Time;
  updatedAt: Time;
  claimedAt: Time | null;
  closedAt: Time | null;
}

export const CONVERSATION_STATUSES = ["menunggu", "aktif", "selesai"] as const;
export type ConversationStatus = (typeof CONVERSATION_STATUSES)[number];

/**
 * schools/{schoolId}/conversations/{id}. Nama asli siswa hanya ada di `displayName` bila tidak memakai
 * nama samaran, atau setelah siswa membuka identitasnya.
 */
export interface ConversationDoc {
  schoolId: string;
  studentUid: string;
  displayName: string;
  usesAlias: boolean;
  identityRevealed: boolean;
  counselorUid: string | null;
  counselorName: string | null;
  status: ConversationStatus;
  topic: string | null;
  lastMessage: {text: string; senderRole: MessageRole; at: Time} | null;
  unreadStudent: number;
  unreadCounselor: number;
  meeting: {at: Timestamp; place: string; status: "diusulkan" | "disetujui" | "ditolak"} | null;
  helpRequestId: string | null;
  createdAt: Time;
  updatedAt: Time;
  closedAt: Time | null;
}

export type MessageRole = "siswa" | "konselor" | "sistem";

/** schools/{schoolId}/conversations/{id}/messages/{messageId} */
export interface MessageDoc {
  senderUid: string | null;
  senderRole: MessageRole;
  text: string;
  imagePath: string | null;
  createdAt: Time;
  /** Pesan dari Cloud Functions (sistem/pesan pembuka) tidak memicu notifikasi ulang. */
  silent?: boolean;
}

export const RISK_LEVELS = ["tidak_ada", "perhatian", "tinggi"] as const;

export const studentHelpRoute = (id: string) => `/home/bantuan/${id}`;
export const staffHelpRoute = (id: string) => `/staff/bantuan/${id}`;
export const studentConversationRoute = (id: string) => `/home/curhat/${id}`;
export const staffConversationRoute = (id: string) => `/staff/curhat/${id}`;
