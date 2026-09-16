# Catatan untuk peninjau Google Play (App review)

Salin isi bagian ini ke **Play Console → App content → App access** dan kolom catatan peninjau saat
mengunggah rilis MANDU.

> **Status:** sudah dimasukkan ke Play Console sebagai dua entri Detail login ("Student demo
> account" dan "School admin demo account") dan dikirim bersama rilis 4.0.0 (13) untuk ditinjau
> pada 16 September 2026.

## Akun uji coba (App access)

Aplikasi memerlukan akun sekolah. Gunakan akun demo berikut — akun ini terhubung ke sekolah demo
"SMA Negeri Demo MANDU" dan sudah berisi contoh data di semua layanan.

| Kolom di Play Console | Isi |
|---|---|
| Nama akun | Akun siswa demo MANDU |
| Username / email | `siswa@smandemo.sch.id` |
| Password | `[disimpan di Play Console > App access]` |
| Instruksi login | Buka aplikasi → ketuk **“Staf sekolah? Masuk dengan email”** → masukkan email dan kata sandi di atas → ketuk **Masuk** → setujui Kebijakan Privasi (centang kedua kotak) → **Setuju dan lanjutkan**. |

Akun cadangan untuk melihat sisi sekolah (opsional): `admin@smandemo.sch.id` dengan kata sandi yang sama.
Akun ini menampilkan antrean verifikasi laporan, kotak aspirasi, dan dashboard sekolah.

> Catatan: domain `smandemo.sch.id` hanya dipakai sebagai identitas akun demo di Firebase Authentication;
> tidak ada email sungguhan yang dikirim ke domain tersebut.

## Ringkasan aplikasi untuk peninjau

MANDU (Media Aspirasi, Notifikasi, dan Dukungan Siswa) adalah aplikasi layanan sekolah dengan lima menu:

1. **Lapor** — siswa melaporkan masalah sekolah (perundungan, fasilitas, kebersihan, pembelajaran).
   Laporan diverifikasi sekolah lalu diteruskan ke unit penanganan. Identitas pelapor dapat dirahasiakan.
2. **Curhat** — percakapan pribadi siswa dengan guru BK, boleh memakai nama samaran.
3. **Aspirasi** — saran/ide/kritik untuk sekolah; dapat dikirim tanpa login lewat kode sekolah.
4. **Butuh Bantuan** — permintaan bantuan singkat kepada guru BK.
5. **Edukasi** — artikel, tautan, dan informasi beasiswa.

Isi Curhat dan Butuh Bantuan hanya dapat dibaca siswa yang bersangkutan dan guru BK sekolahnya.
Aplikasi menampilkan peringatan bahwa MANDU bukan layanan darurat, beserta nomor darurat nasional
(112, SAPA 129, Sehat Jiwa 119 ext. 8).

## Izin yang diminta dan alasannya

| Izin | Alasan |
|---|---|
| Internet | Seluruh data disimpan di Firebase (Firestore, Authentication, Storage). |
| Notifikasi (`POST_NOTIFICATIONS`) | Memberi tahu siswa saat status laporannya berubah, dan memberi tahu guru saat ada laporan/permintaan bantuan baru. |
| Kamera dan berkas (lewat pemilih sistem) | Melampirkan foto atau PDF sebagai bukti laporan, dan mengirim gambar dalam percakapan Curhat. Aplikasi hanya membuka pemilih sistem, tidak memindai galeri. |

## Data safety (ringkas)

- **Dikumpulkan:** nama, email atau NISN, nomor telepon (opsional), sekolah dan kelas, isi
  laporan/aspirasi/percakapan, foto dan dokumen (PDF) yang diunggah pengguna, log error aplikasi,
  token notifikasi perangkat.
- **Tujuan:** menjalankan layanan pengaduan dan konseling sekolah.
- **Dibagikan ke pihak ketiga:** tidak. Data hanya diproses di Firebase milik penyelenggara.
- **Dienkripsi saat transit:** ya (HTTPS/TLS).
- **Kebijakan privasi:** [teman-ngadu.web.app/kebijakan-privasi.html](https://teman-ngadu.web.app/kebijakan-privasi.html)
- **Penghapusan akun:** pengguna meminta lewat admin sekolah (yang mengeluarkannya dari menu Kelola
  Anggota) atau email `temenngadu@gmail.com`; langkahnya ada di
  [teman-ngadu.web.app/hapus-akun.html](https://teman-ngadu.web.app/hapus-akun.html).
- **Konten anak:** aplikasi ditujukan untuk siswa sekolah; saat onboarding pengguna menyatakan bahwa orang
  tua/wali mengetahui penggunaan aplikasi bila pengguna berusia di bawah 18 tahun.
