import {REPORT_CATEGORIES, type Priority} from "../domain/catalog";

/** Kata kunci yang langsung menaikkan prioritas menjadi darurat (keselamatan jiwa). */
const EMERGENCY_KEYWORDS = [
  "bunuh diri", "ingin mati", "pengen mati", "mau mati", "mengakhiri hidup", "menyakiti diri", "melukai diri",
  "menyayat", "senjata tajam", "pisau", "celurit", "dibacok", "ditusuk", "diperkosa", "perkosa", "pemerkosaan",
  "ancam bunuh", "mau dibunuh", "berdarah", "pingsan", "kejang", "tidak aman di rumah",
];

/** Kata kunci kekerasan/perlindungan yang menaikkan prioritas menjadi tinggi. */
const HIGH_KEYWORDS = [
  "dipukul", "memukul", "ditendang", "menendang", "dikeroyok", "berkelahi", "tawuran", "diancam", "mengancam",
  "dipalak", "memalak", "memeras", "diperas", "bully", "dibully", "perundungan", "dirundung", "dilecehkan",
  "pelecehan", "diraba", "foto pribadi", "video pribadi", "disebarkan", "narkoba", "miras", "mabuk", "dikunci",
  "trauma", "takut ke sekolah",
];

const CATEGORY_KEYWORDS: Record<string, string[]> = {
  keamanan: [...HIGH_KEYWORDS, "dicuri", "pencurian", "kehilangan", "orang asing", "tidak aman"],
  fasilitas: [
    "rusak", "bocor", "lampu", "listrik", "kipas", "ac", "kursi", "meja", "papan tulis", "proyektor", "wifi",
    "internet", "komputer", "atap", "plafon", "pintu", "jendela", "keran", "air mati",
  ],
  kebersihan: ["sampah", "kotor", "bau", "jorok", "nyamuk", "tikus", "selokan", "kecoa", "berdebu"],
  pembelajaran: [
    "guru tidak masuk", "jam kosong", "tidak mengajar", "tugas", "nilai", "ujian", "remedial", "materi", "pelajaran",
  ],
  administrasi: ["surat", "legalisir", "spp", "pembayaran", "bayar", "rapor", "ijazah", "tata usaha", "administrasi"],
  kesiswaan: ["ekskul", "ekstrakurikuler", "osis", "lomba", "tata tertib", "seragam", "kedisiplinan", "organisasi"],
};

export interface Classification {
  priority: Priority;
  /** Penjelasan singkat untuk petugas, mis. mengandung kata "dipukul". */
  priorityReason: string | null;
  /** Kategori yang lebih cocok bila berbeda dari pilihan pelapor. */
  suggestedCategory: string | null;
}

const normalize = (text: string) => ` ${text.toLowerCase().replace(/[^a-z0-9]+/g, " ").trim()} `;

/** Klasifikasi berbasis aturan: prioritas dari kategori + kata kunci, dan saran kategori. */
export function classifyTicket(input: {category: string; title: string; description: string; location?: string}): Classification {
  const text = normalize(`${input.title} ${input.description} ${input.location ?? ""}`);
  const contains = (keyword: string) => text.includes(normalize(keyword));

  const categoryPriority = REPORT_CATEGORIES.find((category) => category.key === input.category)?.defaultPriority ?? "normal";
  const emergency = EMERGENCY_KEYWORDS.find(contains);
  const high = HIGH_KEYWORDS.find(contains);

  let priority: Priority = categoryPriority;
  let priorityReason: string | null = null;
  if (emergency) {
    priority = "darurat";
    priorityReason = `Mengandung kata "${emergency}"`;
  } else if (high) {
    priority = "tinggi";
    priorityReason = `Mengandung kata "${high}"`;
  }

  const scores = Object.entries(CATEGORY_KEYWORDS)
    .map(([key, keywords]) => ({key, score: keywords.filter(contains).length}))
    .filter((entry) => entry.score > 0)
    .sort((a, b) => b.score - a.score);
  const chosenScore = scores.find((entry) => entry.key === input.category)?.score ?? 0;
  const best = scores[0];
  const suggestedCategory = best && best.key !== input.category && best.score > chosenScore ? best.key : null;

  return {priority, priorityReason, suggestedCategory};
}

export const normalizeLocation = (location: string) => normalize(location).trim();
