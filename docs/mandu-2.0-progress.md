# MANDU 2.0 — Catatan Progres & Serah Terima

- Rencana lengkap yang disetujui: `/Users/benevology/.claude/plans/snuggly-gathering-gosling.md`
- Branch kerja: `mandu-2.0` (sudah di-push ke `github.com/khrlanamm/mandu`). Jangan bekerja di `master`.
- Daftar bug yang ditemukan dan diperbaiki: `docs/bug-temuan.md`.

## Cara menjalankan (lokal)

```bash
export PATH=/opt/homebrew/opt/openjdk@21/bin:$PATH

# 1. Emulator Suite (dari root repo)
npm --prefix functions run build
firebase emulators:start --only auth,firestore,functions,storage --project teman-ngadu

# 2. Data uji coba: sekolah, akun demo (password mandu123), contoh laporan/aspirasi/bantuan/curhat/edukasi
cd functions && npm run seed:emulator

# 3. Aplikasi Android terhubung ke emulator (APK debug universal terlalu besar untuk emulator)
flutter build apk --debug --split-per-abi --target-platform android-arm64 --dart-define=MANDU_EMULATOR=true
adb install -r build/app/outputs/flutter-apk/app-arm64-v8a-debug.apk
```

Data Emulator Suite tidak disimpan; setiap emulator dinyalakan ulang, jalankan seed lagi.
Setiap kali menambah atau mengubah Cloud Functions, jalankan `npm --prefix functions run build`
agar emulator memuat versi terbaru (kalau tidak, aplikasi menerima error `NOT_FOUND`).

**Tes**
- Backend + rules: `cd functions && npm run test:emulator` → **71 tes** (memakai port emulator terpisah `firebase.test.json`, aman berjalan bersama emulator dev).
- Flutter: `flutter analyze && flutter test` → 18 tes.

## Akun uji coba (emulator, password `mandu123`)

| Peran | Login |
|---|---|
| Superadmin | `superadmin@mandu.test` |
| Admin Sekolah (Tim Verifikasi) | `admin@smandemo.sch.id` |
| Pimpinan | `kepsek@smandemo.sch.id` |
| Konselor (BK, Tim Verifikasi) | `bk@smandemo.sch.id` |
| Petugas Sarpras | `sarpras@smandemo.sch.id` |
| Petugas Kurikulum (Tim Verifikasi) | `kurikulum@smandemo.sch.id` |
| Siswa | `siswa@smandemo.sch.id` (Budi), `siswa2@smandemo.sch.id` (Siti) |
| Calon siswa (menunggu persetujuan) | `calon.siswa@mandu.test` |
| Siswa akun NISN | kode `DEMO01` · NISN `0059990001` |
| Admin sekolah kedua | `admin@smpharapan.sch.id` (kode `HARAPAN`) |

Sekolah demo: **SMA Negeri Demo MANDU**, kode gabung `DEMO01`.

## Selesai

### Tahap 0–1 — Fondasi, identitas, multi-sekolah
- Brand, ikon, dan splash MANDU 2.0 (`tool/brand/generate.sh`).
- Flutter 3.47 + Riverpod 3 + go_router 18 + freezed 4; Cloud Functions TypeScript (firebase-functions v7).
- Login Google, akun NISN, dan email staf; onboarding (persetujuan privasi, ganti password, gabung sekolah lewat kode/QR).
- Peran: superadmin, admin sekolah, pimpinan, konselor, petugas unit, siswa; custom claims `{sid, role, units[], canVerify}`.
- Admin sekolah: persetujuan siswa, anggota & peran, undang staf, impor CSV NISN, pengaturan sekolah & kode.

### Tahap 2 — Lapor
- Nomor `MND-YYYY-NNNN`, klasifikasi prioritas otomatis, saran kategori, deteksi kemungkinan duplikat.
- Identitas pelapor disimpan terpisah (`ticketOwners`) sehingga mode rahasia benar-benar rahasia.
- Alur: verifikasi (teruskan / minta data / tolak) → unit menangani (progres, catatan internal) → selesai → penilaian siswa.
- SLA: batas verifikasi & tindak lanjut, penanda terlambat, pengingat terjadwal tiap jam.
- Lampiran foto/PDF di Storage dengan cross-service rules.

### Tahap 3 — Aspirasi
- Siswa mengirim aspirasi (identitas bisa dirahasiakan) dan tamu lewat `/s/{kode}/aspirasi` tanpa login.
- Penyamaran kata kasar, pembatasan pengiriman per IP dan per akun.
- Tanggapan resmi sekolah, status (diterima → ditinjau → ditindaklanjuti → direalisasikan / belum dapat).
- Papan aspirasi untuk siswa dengan dukungan satu suara per siswa.

### Tahap 4 — Curhat & Butuh Bantuan
- Butuh Bantuan: pilih kebutuhan, urgensi, cara & waktu dihubungi; konselor mengambil, lanjut ke percakapan, lalu menutup dengan pesan penutup.
- Curhat: pilih konselor atau "siapa saja", nama samaran, chat teks/gambar realtime, buka identitas, usulan jadwal temu, catatan kasus privat konselor.
- Hanya siswa pemilik dan konselor terkait yang bisa membaca; admin sekolah tidak.
- Kontak darurat nasional (112, 129, 119) tampil di layanan ini.

### Tahap 5 — Edukasi
- Artikel global (superadmin) dan artikel sekolah (admin/konselor): artikel Markdown, tautan, dan info beasiswa dengan tenggat.
- Pencarian, filter kategori, konten unggulan, tersimpan (bookmark), hitungan dibaca.

### Tahap 6 — Dashboard
- Agregasi statistik sekolah: status & kategori laporan, tren bulanan, kinerja tiap unit (rata-rata waktu dan % tepat waktu), kepuasan pelapor, lokasi teratas, ringkasan aspirasi/BK/anggota.
- Dashboard Flutter dengan grafik (fl_chart), pilihan periode 3/6/12 bulan, dan ekspor CSV.
- Dashboard platform superadmin: jumlah sekolah, anggota, laporan, dan aspirasi per sekolah (tanpa isi).

### Manual penggunaan
- Naskah: `docs/manual/manual-mandu.html` (18 bab: siswa, Tim Verifikasi, petugas unit, guru BK, admin, pimpinan, superadmin, tamu, privasi, FAQ).
- Tangkapan layar: `docs/manual/img/` (diambil dari emulator Android memakai akun uji coba).
- Buat PDF: `docs/manual/render.sh` → `docs/manual/manual-mandu.pdf`.

### Verifikasi langsung di emulator Android
Diuji memakai akun uji coba, bukan hanya lewat tes otomatis:
- Siswa: masuk, beranda 5 layanan, **kirim laporan baru sampai terbit nomor `MND-2026-0007`**, Aktivitas, detail laporan selesai + penilaian, Curhat (kirim pesan), Butuh Bantuan, Aspirasi, Edukasi, notifikasi.
- Tim Verifikasi/admin: tab Tugas, detail laporan, **verifikasi & teruskan laporan darurat**, persetujuan siswa, kotak aspirasi + **tanggapan resmi tersimpan**, konten Edukasi sekolah, dashboard.
- Konselor: ruang konselor (antrean bantuan + percakapan curhat).
- Superadmin: daftar sekolah dan dashboard platform.
- Tamu: aspirasi tanpa login lewat kode sekolah.
- Keluar akun diuji ulang pada setiap peran setelah perbaikan dependensi melingkar.

## Sedang dikerjakan
- Melengkapi tangkapan layar manual untuk peran staf, konselor, dan superadmin, lalu merender PDF final.
- Dashboard web sudah live di **https://teman-ngadu.web.app** (hosting saja; fungsinya penuh setelah functions & rules 2.0 di-deploy pada tahap 7).

### Migrasi data aplikasi 4.0.0 (siap, sudah diuji di emulator)
Skrip `functions/scripts/migrate.ts` memindahkan laporan lama menjadi tiket, memberi field `published`
pada artikel lama, serta menyiapkan superadmin dan admin sekolah. Aman dijalankan berulang.

```bash
cd functions
npm run seed:legacy       # data tiruan aplikasi lama (emulator saja)
npm run migrate:dryrun    # ringkasan tanpa menulis apa pun
npm run migrate:emulator  # jalankan di emulator
# Produksi (setelah dry-run cocok dan mendapat persetujuan):
GOOGLE_APPLICATION_CREDENTIALS=~/.config/mandu/service-account.json GCLOUD_PROJECT=teman-ngadu \
  npx tsx scripts/migrate.ts --school-code SMANDI --apply --production
```

Hasil uji di emulator: 3 laporan lama → 1 tiket menunggu verifikasi + 2 tiket selesai (identitas pelapor
dirahasiakan, bukti lama tetap terbaca lewat path Storage), 3 artikel lama diberi `published`,
2 superadmin dan 2 admin sekolah dibuat, pelapor lama menjadi anggota siswa aktif.

## Berikutnya
- **Manual book PDF** penggunaan aplikasi + dashboard memakai akun uji coba.
- **Tahap 7 — Rilis**
  - Migrasi produksi: 44 laporan → tiket, 50 artikel (**wajib menambahkan field `published: true`**), superadmin & admin sekolah.
  - Seed "Sekolah Uji Coba MANDU" di produksi.
  - Deploy functions, rules, dan indexes; aktifkan App Check.
  - Build AAB versionName 4.0.0 (versionCode ≥ 13) dan unggah ke Play Console — **dikerjakan belakangan sesuai permintaan user**.

## Catatan keamanan
- Password keystore hanya di `android/key.properties` (gitignored); service account di `~/.config/mandu/`.
- Produksi masih memakai functions dan rules aplikasi 4.0.0. Kode MANDU 2.0 belum di-deploy.
- Pengujian notifikasi push dilakukan user di perangkat nyata (bukan di emulator).
