/**
 * Katalog bawaan MANDU 2.0. Aplikasi Flutter memakai salinan yang sama
 * (lib/core/domain/catalog.dart) — ubah keduanya bersamaan.
 */

export type Priority = "normal" | "tinggi" | "darurat";

export interface Subcategory {
  key: string;
  label: string;
}

export interface CategoryDefinition {
  key: string;
  label: string;
  description: string;
  defaultUnitId: string;
  defaultPriority: Priority;
  subcategories: readonly Subcategory[];
}

export const REPORT_CATEGORIES: readonly CategoryDefinition[] = [
  {
    key: "keamanan",
    label: "Keamanan & Perlindungan",
    description: "Perundungan, kekerasan, pelecehan, ancaman, dan rasa tidak aman di sekolah.",
    defaultUnitId: "bk_ppks",
    defaultPriority: "tinggi",
    subcategories: [
      {key: "perundungan", label: "Perundungan (bullying)"},
      {key: "perundungan_siber", label: "Perundungan siber"},
      {key: "kekerasan_fisik", label: "Kekerasan fisik"},
      {key: "kekerasan_verbal", label: "Kekerasan verbal / psikis"},
      {key: "pelecehan_seksual", label: "Pelecehan seksual"},
      {key: "diskriminasi", label: "Diskriminasi / intoleransi"},
      {key: "ancaman_keamanan", label: "Ancaman keamanan (pencurian, orang asing)"},
      {key: "lainnya", label: "Lainnya"},
    ],
  },
  {
    key: "fasilitas",
    label: "Fasilitas & Sarana",
    description: "Kerusakan bangunan, perabot, listrik, air, dan peralatan belajar.",
    defaultUnitId: "sarpras",
    defaultPriority: "normal",
    subcategories: [
      {key: "bangunan", label: "Bangunan & ruang kelas"},
      {key: "perabot", label: "Meja, kursi, papan tulis"},
      {key: "listrik_air", label: "Listrik & air"},
      {key: "toilet", label: "Toilet"},
      {key: "laboratorium", label: "Laboratorium & perpustakaan"},
      {key: "teknologi", label: "Komputer, proyektor, internet"},
      {key: "lainnya", label: "Lainnya"},
    ],
  },
  {
    key: "pembelajaran",
    label: "Pembelajaran",
    description: "Kegiatan belajar mengajar, jadwal, tugas, dan penilaian.",
    defaultUnitId: "kurikulum",
    defaultPriority: "normal",
    subcategories: [
      {key: "jam_kosong", label: "Jam kosong / guru tidak hadir"},
      {key: "metode", label: "Cara mengajar"},
      {key: "tugas_materi", label: "Tugas & materi"},
      {key: "penilaian", label: "Penilaian & ujian"},
      {key: "jadwal", label: "Jadwal pelajaran"},
      {key: "lainnya", label: "Lainnya"},
    ],
  },
  {
    key: "kebersihan",
    label: "Kebersihan & Lingkungan",
    description: "Sampah, kebersihan ruang, kantin, dan lingkungan sekolah.",
    defaultUnitId: "sarpras",
    defaultPriority: "normal",
    subcategories: [
      {key: "sampah", label: "Sampah"},
      {key: "ruang_kelas", label: "Kebersihan ruang kelas"},
      {key: "toilet", label: "Kebersihan toilet"},
      {key: "kantin", label: "Kantin & makanan"},
      {key: "lingkungan", label: "Taman & lingkungan"},
      {key: "lainnya", label: "Lainnya"},
    ],
  },
  {
    key: "administrasi",
    label: "Layanan Administrasi",
    description: "Surat-menyurat, data siswa, pembayaran, dan layanan tata usaha.",
    defaultUnitId: "tata_usaha",
    defaultPriority: "normal",
    subcategories: [
      {key: "surat", label: "Surat & legalisasi"},
      {key: "data_siswa", label: "Data siswa / rapor"},
      {key: "pembayaran", label: "Pembayaran"},
      {key: "pelayanan", label: "Pelayanan petugas"},
      {key: "lainnya", label: "Lainnya"},
    ],
  },
  {
    key: "kesiswaan",
    label: "Kesiswaan",
    description: "Ekstrakurikuler, OSIS, tata tertib, dan kegiatan siswa.",
    defaultUnitId: "kesiswaan",
    defaultPriority: "normal",
    subcategories: [
      {key: "ekstrakurikuler", label: "Ekstrakurikuler"},
      {key: "osis", label: "OSIS & organisasi"},
      {key: "tata_tertib", label: "Tata tertib & kedisiplinan"},
      {key: "kegiatan", label: "Kegiatan & lomba"},
      {key: "lainnya", label: "Lainnya"},
    ],
  },
  {
    key: "lainnya",
    label: "Lainnya",
    description: "Persoalan lain yang perlu ditangani sekolah.",
    defaultUnitId: "manajemen",
    defaultPriority: "normal",
    subcategories: [{key: "lainnya", label: "Lainnya"}],
  },
];

export const CATEGORY_KEYS = REPORT_CATEGORIES.map((category) => category.key);

export interface UnitTemplate {
  id: string;
  name: string;
  description: string;
  categories: readonly string[];
}

export const DEFAULT_UNITS: readonly UnitTemplate[] = [
  {id: "bk_ppks", name: "BK / Tim PPKS", description: "Bimbingan Konseling dan Tim Pencegahan & Penanganan Kekerasan", categories: ["keamanan"]},
  {id: "sarpras", name: "Sarana & Prasarana", description: "Fasilitas, kebersihan, dan lingkungan sekolah", categories: ["fasilitas", "kebersihan"]},
  {id: "kurikulum", name: "Wakasek Kurikulum", description: "Kegiatan belajar mengajar", categories: ["pembelajaran"]},
  {id: "kesiswaan", name: "Wakasek Kesiswaan", description: "Kegiatan dan pembinaan siswa", categories: ["kesiswaan"]},
  {id: "tata_usaha", name: "Tata Usaha", description: "Layanan administrasi", categories: ["administrasi"]},
  {id: "manajemen", name: "Tim Manajemen", description: "Persoalan lain dan koordinasi pimpinan", categories: ["lainnya"]},
];

export const SCHOOL_LEVELS = ["SD", "SMP", "MTs", "SMA", "SMK", "MA", "SLB", "Lainnya"] as const;

export const DEFAULT_SERVICES = {lapor: true, curhat: true, aspirasi: true, bantuan: true, edukasi: true};

export const DEFAULT_SLA_HOURS = {verifikasi: 24, tindakLanjut: 72, darurat: 2};

/** Versi kebijakan privasi; naikkan bila isi kebijakan berubah agar pengguna menyetujui ulang. */
export const CONSENT_VERSION = "2026-09";
