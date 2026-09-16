import type {TicketDoc} from "../domain/tickets";

/**
 * Perubahan bentuk data aplikasi MANDU 4.0.0 → MANDU 2.0.
 * Fungsi di sini murni (tanpa Firestore) supaya bisa diuji tanpa emulator.
 */

/** Ambil path Storage dari URL unduhan Firebase (…/o/laporan_bukti%2Ffile.jpg?alt=media&token=…). */
export function storagePathFromUrl(url: string | undefined | null): string | null {
  if (!url) return null;
  const match = /\/o\/([^?]+)/.exec(url);
  return match ? decodeURIComponent(match[1]) : null;
}

/** Laporan lama tidak punya judul; ambil kalimat pertama deskripsi (maksimal 120 karakter). */
export function titleFromDescription(description: string): string {
  const text = description.trim();
  if (text.length === 0) return "Laporan perundungan";
  const firstSentence = text.split(/[.\n]/)[0]?.trim() ?? "";
  const source = firstSentence.length >= 10 ? firstSentence : text;
  if (source.length <= 120) return source;
  return `${source.slice(0, 117)}...`;
}

/** Status laporan lama (`terlapor` / `ditangani`) → status tiket MANDU 2.0. */
export function statusFromLegacy(status: string | undefined | null): TicketDoc["status"] {
  return status === "ditangani" ? "selesai" : "menunggu_verifikasi";
}

/** Peran pelapor lama hanya boleh "korban" atau "saksi". */
export function roleFromLegacy(peran: unknown): "korban" | "saksi" | null {
  return peran === "korban" || peran === "saksi" ? peran : null;
}

/** Nomor tiket hasil migrasi: MND-<tahun laporan>-<urut 4 digit>. */
export function legacyTicketNumber(year: string, sequence: number): string {
  return `MND-${year}-${String(sequence).padStart(4, "0")}`;
}

/** Artikel lama menjadi "artikel" bila isinya cukup panjang, selain itu jadi "tautan". */
export function articleTypeFromLegacy(body: string, link: string | undefined | null): "artikel" | "tautan" {
  return body.trim().length >= 30 || !link ? "artikel" : "tautan";
}
