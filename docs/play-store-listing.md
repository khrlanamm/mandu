# Naskah listing Play Store — MANDU 2.0

Salin isi bagian ini ke **Play Console → Kembangkan basis pengguna → Listingan Play Store**.
Sumber gambar toko ada di `store/` (dibuat oleh `tool/store/generate.py`, lihat catatan di bagian akhir).

## Nama aplikasi (maks 30 karakter)

```
MANDU Lapor & Aspirasi Sekolah
```
(30/30 karakter)

## Deskripsi singkat (maks 80 karakter)

```
Lapor, curhat, aspirasi, bantuan, dan edukasi dalam satu aplikasi sekolah.
```
(74/80 karakter)

## Deskripsi lengkap (maks 4000 karakter)

```
MANDU — Media Aspirasi, Notifikasi, dan Dukungan Siswa. Satu aplikasi sekolah dengan
lima layanan: melapor masalah, curhat rahasia dengan guru BK, menyampaikan aspirasi,
meminta bantuan, dan membaca konten edukasi.

MANDU dipakai banyak sekolah. Setiap sekolah punya kode gabung sendiri, dan data tiap
sekolah terpisah aman satu sama lain.

LIMA LAYANAN MANDU

📢 Lapor
Laporkan masalah di sekolah — perundungan, kekerasan, fasilitas rusak, kebersihan,
pembelajaran, atau hal lain — lengkap dengan foto bukti kalau ada. Tim sekolah
memverifikasi laporanmu, meneruskannya ke unit yang tepat, dan mengabarimu di setiap
tahap sampai selesai. Untuk laporan yang sensitif, kamu bisa memilih "Rahasiakan
identitas" — identitasmu tidak akan terlihat oleh staf mana pun yang menangani laporan
itu, dan kamu tetap bisa melacak status laporanmu sendiri.

💬 Curhat
Cerita apa pun ke guru BK sekolahmu, kapan saja, lewat percakapan pribadi. Kamu boleh
memakai nama samaran. Hanya kamu dan guru BK yang menanganimu yang bisa membaca
percakapan ini — staf sekolah lain, termasuk pengelola aplikasi, tidak bisa membukanya.

💡 Aspirasi
Sampaikan saran, ide, usulan, atau kritik untuk sekolahmu. Aspirasi yang disetujui bisa
tampil di Papan Aspirasi dan didukung siswa lain, lengkap dengan tanggapan resmi
sekolah. Tamu pun bisa mengirim aspirasi tanpa perlu masuk akun, cukup dengan kode
sekolah.

🤝 Butuh Bantuan
Kadang kamu butuh bicara tapi belum siap menjelaskan panjang lebar. Cukup pilih apa
yang kamu butuhkan, tingkat urgensi, dan cara dihubungi — guru BK akan menghubungimu.

📚 Edukasi
Bacaan seputar anti-perundungan, kesehatan mental remaja, etika digital, hak dan
kewajiban siswa, cara mencari bantuan, layanan BK sekolah, sampai info beasiswa —
disajikan dengan bahasa yang mudah dipahami pelajar.

UNTUK SEKOLAH
Sekolah bisa mendaftarkan siswa lewat kode gabung, akun NISN, atau mengundang staf
langsung (admin, kepala sekolah, guru BK, dan petugas unit penanganan). Admin sekolah
dan kepala sekolah mendapat dashboard: jumlah laporan per status, tren bulanan, kategori
terbanyak, dan performa setiap unit — tanpa membuka isi percakapan pribadi siswa.

PRIVASI DAN KEAMANAN
Data disimpan aman di Firebase dan dikirim lewat koneksi terenkripsi. Akses ke setiap
data dibatasi sesuai peran masing-masing pengguna di sekolahnya. Lihat kebijakan
privasi lengkap dan cara menghapus akun di teman-ngadu.web.app.

MANDU bukan layanan darurat. Jika kamu atau orang lain dalam bahaya, segera hubungi
nomor darurat nasional 112, SAPA Kementerian PPPA 129, atau Sehat Jiwa Kemenkes 119
ext. 8, atau orang dewasa terdekat.
```

## Ikon dan gambar toko

| Aset | Berkas | Ukuran |
|---|---|---|
| Ikon aplikasi | `store/icon-512.png` | 512×512 |
| Gambar fitur | `store/feature-graphic.png` | 1024×500 |
| Screenshot ponsel (8) | `store/0N-*-phone.png` | 1080×1920 |
| Screenshot tablet 7 inci (8) | `store/0N-*-tablet7.png` | 1920×1200 |
| Screenshot tablet 10 inci (8) | `store/0N-*-tablet10.png` | 1920×1200 |

Urutan unggah screenshot ponsel/tablet (nomor menentukan urutan tampil di Play Store):

1. `01-beranda` — 5 layanan sekolah dalam satu aplikasi
2. `02-lapor` — Lapor masalah sekali klik
3. `03-aktivitas` — Pantau laporanmu sampai selesai
4. `04-curhat` — Curhat rahasia dengan Guru BK
5. `05-aspirasi` — Aspirasi ditanggapi sekolah
6. `06-bantuan` — Butuh bantuan? Satu tombol saja
7. `07-edukasi` — Bacaan dan info beasiswa
8. `08-dashboard` — Dashboard untuk sekolah

## Setelan Store

- **Situs web:** `https://teman-ngadu.web.app`
- **Kategori:** Aplikasi → Pendidikan
- **Tag:** Pendidikan, Alat, Buku & referensi (buang "Mengasuh Anak" — tidak relevan lagi)
- **Email kontak:** `temenngadu@gmail.com` (tidak berubah)

## Cara membuat ulang aset gambar

Sumber: `design/logo/mandu-symbol.svg` + tangkapan layar aplikasi produksi.
Skrip: `tool/store/generate.py` (Python 3 + Google Chrome headless untuk merender
HTML/CSS ke PNG pada ukuran piksel yang tepat). Jalankan `python3 tool/store/generate.py`
dari root repo setelah memperbarui tangkapan layar di `store/raw/`.
