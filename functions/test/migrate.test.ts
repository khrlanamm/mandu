import {describe, expect, it} from "vitest";
import {
  articleTypeFromLegacy,
  legacyTicketNumber,
  roleFromLegacy,
  statusFromLegacy,
  storagePathFromUrl,
  titleFromDescription,
} from "../src/migration/legacy";

describe("migrasi data aplikasi 4.0.0", () => {
  it("mengambil path Storage dari URL bukti lama", () => {
    expect(storagePathFromUrl("https://firebasestorage.googleapis.com/v0/b/teman-ngadu.appspot.com/o/laporan_bukti%2Fbukti1.jpg?alt=media&token=abc"))
      .toBe("laporan_bukti/bukti1.jpg");
    expect(storagePathFromUrl("")).toBeNull();
    expect(storagePathFromUrl(undefined)).toBeNull();
    expect(storagePathFromUrl("https://contoh.test/gambar.jpg")).toBeNull();
  });

  it("membuat judul dari deskripsi laporan lama", () => {
    expect(titleFromDescription("Saya diejek terus di kelas. Sudah sejak awal semester."))
      .toBe("Saya diejek terus di kelas");
    // Kalimat pertama terlalu pendek: pakai seluruh deskripsi.
    expect(titleFromDescription("Tolong. Teman saya didorong sampai jatuh di lapangan."))
      .toBe("Tolong. Teman saya didorong sampai jatuh di lapangan.");
    expect(titleFromDescription("   ")).toBe("Laporan perundungan");
    const panjang = titleFromDescription("x".repeat(200));
    expect(panjang).toHaveLength(120);
    expect(panjang.endsWith("...")).toBe(true);
  });

  it("memetakan status, peran, dan nomor tiket", () => {
    expect(statusFromLegacy("ditangani")).toBe("selesai");
    expect(statusFromLegacy("terlapor")).toBe("menunggu_verifikasi");
    expect(statusFromLegacy(undefined)).toBe("menunggu_verifikasi");
    expect(roleFromLegacy("korban")).toBe("korban");
    expect(roleFromLegacy("pelapor")).toBeNull();
    expect(legacyTicketNumber("2025", 7)).toBe("MND-2025-0007");
    expect(legacyTicketNumber("2025", 44)).toBe("MND-2025-0044");
  });

  it("memilih jenis konten Edukasi dari artikel lama", () => {
    expect(articleTypeFromLegacy("Isi artikel yang cukup panjang untuk dibaca siswa.", null)).toBe("artikel");
    expect(articleTypeFromLegacy("", "https://kemenpppa.go.id")).toBe("tautan");
    // Tanpa tautan, isi pendek pun tetap disimpan sebagai artikel.
    expect(articleTypeFromLegacy("Pendek", null)).toBe("artikel");
  });
});
