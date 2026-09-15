import type {Time} from "./models";

/** Edukasi: artikel global (superadmin) dan artikel sekolah. */
export const ARTICLE_CATEGORIES = [
  {key: "anti_bullying", label: "Anti-Perundungan"},
  {key: "kesehatan_mental", label: "Kesehatan Mental Remaja"},
  {key: "etika_digital", label: "Etika Digital"},
  {key: "hak_kewajiban", label: "Hak & Kewajiban Siswa"},
  {key: "cari_bantuan", label: "Cara Mencari Bantuan"},
  {key: "keamanan_sekolah", label: "Keamanan Sekolah"},
  {key: "layanan_bk", label: "Layanan BK"},
  {key: "beasiswa", label: "Beasiswa"},
] as const;
export const ARTICLE_CATEGORY_KEYS = ARTICLE_CATEGORIES.map((category) => category.key);

export const ARTICLE_TYPES = ["artikel", "tautan", "beasiswa"] as const;
export type ArticleType = (typeof ARTICLE_TYPES)[number];

export interface ScholarshipInfo {
  organizer: string;
  level: string;
  /** yyyy-MM-dd */
  deadline: string;
  url: string;
}

/** `articles/{id}` (global) atau `schools/{schoolId}/articles/{id}` (sekolah). */
export interface ArticleDoc {
  title: string;
  category: string;
  categoryLabel: string;
  type: ArticleType;
  summary: string;
  /** Isi artikel dalam Markdown (kosong untuk tautan dan beasiswa). */
  body: string;
  /** Tautan eksternal (https) untuk tipe tautan/beasiswa. */
  url: string | null;
  coverUrl: string | null;
  scholarship: ScholarshipInfo | null;
  featured: boolean;
  published: boolean;
  views: number;
  scope: "global" | "school";
  schoolId: string | null;
  authorName: string;
  createdAt: Time;
  updatedAt: Time;
  publishedAt: Time | null;
}

export const articleRoute = (id: string) => `/home/edukasi/${id}`;
