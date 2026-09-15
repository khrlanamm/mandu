import type {Time} from "./models";

export const ASPIRATION_TYPES = ["saran", "ide", "usulan", "kritik"] as const;
export type AspirationType = (typeof ASPIRATION_TYPES)[number];

export const ASPIRATION_TYPE_LABELS: Record<AspirationType, string> = {
  saran: "Saran",
  ide: "Ide",
  usulan: "Usulan",
  kritik: "Kritik konstruktif",
};

/** Salin juga ke lib/features/aspirasi/domain/aspiration.dart bila berubah. */
export const ASPIRATION_TOPICS = [
  {key: "fasilitas", label: "Fasilitas & sarana"},
  {key: "pembelajaran", label: "Pembelajaran"},
  {key: "kegiatan", label: "Kegiatan & ekstrakurikuler"},
  {key: "lingkungan", label: "Kebersihan & lingkungan"},
  {key: "kantin", label: "Kantin"},
  {key: "layanan", label: "Layanan sekolah"},
  {key: "kebijakan", label: "Aturan & kebijakan"},
  {key: "lainnya", label: "Lainnya"},
] as const;
export const ASPIRATION_TOPIC_KEYS = ASPIRATION_TOPICS.map((topic) => topic.key);

export const ASPIRATION_STATUSES = ["diterima", "ditinjau", "ditindaklanjuti", "direalisasikan", "belum_dapat"] as const;
export type AspirationStatus = (typeof ASPIRATION_STATUSES)[number];

export const ASPIRATION_STATUS_LABELS: Record<AspirationStatus, string> = {
  diterima: "Diterima",
  ditinjau: "Sedang ditinjau",
  ditindaklanjuti: "Ditindaklanjuti",
  direalisasikan: "Direalisasikan",
  belum_dapat: "Belum dapat ditindaklanjuti",
};

/** none: belum diputuskan, published: tampil di papan siswa, hidden: tidak ditampilkan. */
export const BOARD_STATES = ["none", "published", "hidden"] as const;
export type BoardState = (typeof BOARD_STATES)[number];

/** schools/{schoolId}/aspirations/{id} — tidak memuat identitas pengirim. */
export interface AspirationDoc {
  number: string;
  schoolId: string;
  type: AspirationType;
  typeLabel: string;
  topic: string;
  topicLabel: string;
  title: string;
  content: string;
  source: "siswa" | "tamu";
  anonymous: boolean;
  /** Mengandung kata kasar (sudah disamarkan). */
  flagged: boolean;
  status: AspirationStatus;
  response: {message: string; respondedByName: string; respondedAt: Time} | null;
  board: BoardState;
  publishedAt: Time | null;
  supportCount: number;
  createdAt: Time;
  updatedAt: Time;
}

/** schools/{schoolId}/aspirations/{id}/private/identity — hanya staf; hanya ada bila pengirim tidak merahasiakan identitas. */
export interface AspirationIdentityDoc {
  name: string;
  kelas: string | null;
}

/** schools/{schoolId}/aspirationOwners/{id} — hanya dibaca pengirim (siswa yang masuk). */
export interface AspirationOwnerDoc {
  uid: string;
  createdAt: Time;
}

export const studentAspirationRoute = (id: string) => `/home/aspirasi/${id}`;
export const staffAspirationRoute = (id: string) => `/staff/aspirasi/${id}`;
