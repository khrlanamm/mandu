# MANDU 2.0 — Catatan Progres & Serah Terima

- Rencana lengkap yang sudah disetujui: `/Users/benevology/.claude/plans/snuggly-gathering-gosling.md`
- Branch kerja: `mandu-2.0`. Jangan bekerja di `master`.

## Cara menjalankan (lokal)

```bash
export PATH=/opt/homebrew/opt/openjdk@21/bin:$PATH

# 1. Emulator Suite (dari root repo)
npm --prefix functions run build
firebase emulators:start --only auth,firestore,functions,storage --project teman-ngadu

# 2. Data uji coba (terminal lain): sekolah, akun demo (password mandu123), 6 contoh laporan
cd functions && npm run seed:emulator

# 3. Aplikasi Android terhubung ke emulator
flutter build apk --debug --split-per-abi --target-platform android-arm64 --dart-define=MANDU_EMULATOR=true
adb install -r build/app/outputs/flutter-apk/app-arm64-v8a-debug.apk
```

- APK debug universal (±200 MB) gagal dipasang karena penyimpanan emulator penuh. Gunakan build `arm64` di atas.
- Di layar "Masuk dengan email" ada daftar akun demo yang bisa langsung diketuk.

**Tes**
- Functions dan rules: `cd functions && npm run test:emulator` → 43 tes. Tes memakai port emulator terpisah (`firebase.test.json`), jadi bisa berjalan bersamaan dengan emulator dev.
- Flutter: `flutter analyze && flutter test` → 18 tes.

## Selesai

### Tahap 0 — Fondasi
- Logo dan brand:
  - logo konsep A "Suara Siswa" (`design/logo/*.svg`);
  - ikon Android dan web dibuat dengan `tool/brand/generate.sh`.
- Toolchain: Flutter 3.47.4 / Dart 3.13.3, Riverpod 3 + generator, go_router 18, freezed 4.
- Cloud Functions ditulis dengan TypeScript: firebase-functions v7, admin v14, zod 4, vitest.

### Tahap 1 — Identitas & multi-sekolah
Backend (commit `3f29808`):
- Callable functions:
  - `account-*`: sync, consent, ganti password, nama, register/unregister device;
  - `schools-*`: lookup, create, update, changeCode;
  - `members-*`: join, review, update, remove, invite, importStudents, resetStudentPassword.
- Custom claims: `{sa}` untuk superadmin; `{sid, role, units[], canVerify}` untuk anggota sekolah.
- Email akun NISN: `{schoolId}.{nisn}@nisn.teman-ngadu.web.app`.

Aplikasi (commit `dbd06d8`):
- Login: Google, NISN, email staf.
- Onboarding: persetujuan privasi, ganti password awal, gabung sekolah lewat kode atau QR, layar menunggu persetujuan.
- Shell per peran: siswa, staf, superadmin.
- Admin sekolah: persetujuan siswa, anggota & peran, undang staf, impor CSV NISN, pengaturan sekolah.
- Superadmin: daftar sekolah dan buat sekolah.
- Diverifikasi di emulator Android: login admin, beranda, dan persetujuan siswa berjalan.

### Skrip seed `functions/scripts/seed.ts`
**Emulator** (password `mandu123`):

| Sekolah | Akun |
|---|---|
| — | `superadmin@mandu.test` |
| SMA Negeri Demo MANDU (kode `DEMO01`) | `admin@` (verifikator), `kepsek@`, `bk@` (bk_ppks, verifikator), `sarpras@`, `kurikulum@` (verifikator), `siswa@` (Budi), `siswa2@` (Siti) — semua `@smandemo.sch.id` |
| SMA Negeri Demo MANDU | `calon.siswa@mandu.test` (menunggu persetujuan) |
| SMA Negeri Demo MANDU | NISN `0059990001` (wajib ganti password) |
| SMP Harapan Bangsa (kode `HARAPAN`) | `admin@smpharapan.sch.id` |

**Enam contoh laporan**, satu per status:
1. Selesai dan dinilai
2. Perundungan siber rahasia, sedang diproses BK, ada catatan internal
3. Menunggu verifikasi, lewat batas waktu
4. Perlu dilengkapi
5. Ditolak (bukan wewenang)
6. Darurat

**Produksi** (`--production --password <≥12>`):
- Hanya "Sekolah Uji Coba MANDU" (kode `UJICOBA`, domain `ujicoba.mandu.test`).
- Tanpa superadmin demo.

### Tahap 2 — Lapor end-to-end
Backend (commit `3174004`):
- `tickets-submit`:
  - nomor `MND-YYYY-NNNN` per sekolah per tahun;
  - klasifikasi prioritas dari kata kunci;
  - saran kategori;
  - deteksi kemungkinan duplikat (7 hari, lokasi sama);
  - identitas pelapor disimpan terpisah di `ticketOwners`.
- `tickets-verify`: teruskan, minta data, atau tolak.
- Callable lain: `supplyInfo`, `cancel`, `addProgress` (publik atau internal), `resolve`, `reassign`, `rate`.
- Notifikasi: kotak masuk `users/{uid}/notifications` + FCM (kanal `mandu_urgent`/`mandu_updates`).
- `slaReminders` terjadwal setiap 60 menit.
- Rules Firestore/Storage untuk laporan, timeline, lampiran, dan tindak lanjut.

Aplikasi (commit `84ee61d`):
- **Siswa**
  - Lapor: pilih kategori → formulir (lampiran foto/PDF, mode rahasia, detail keamanan).
  - Tab Aktivitas.
  - Detail laporan: progres, riwayat publik, lengkapi data, batalkan, beri penilaian.
- **Staf**
  - Tab Tugas: filter per status dan antrean prioritas.
  - Detail laporan: pelapor atau "dirahasiakan", tanda duplikat, saran kategori.
  - Aksi: Tolak / Minta data / Teruskan (kategori, unit, prioritas), Tambah progres / Selesaikan, catatan internal, alihkan unit.
  - Beranda staf menampilkan ringkasan laporan.
- **Umum:** notifikasi (tab siswa, lonceng staf, badge), registrasi token FCM saat login dan pelepasan saat keluar.

## Sedang dikerjakan
- Uji alur Lapor di emulator Android (siswa → verifikator → unit → siswa menilai).
  - Perbaikan pertama: bar aksi di detail laporan staf memenuhi layar (Align tanpa `heightFactor`).

## Berikutnya
- **Tahap 3 — Aspirasi**
  - Siswa login, dengan opsi sembunyikan identitas.
  - Tamu tanpa login lewat `/s/{kode}/aspirasi` (web + app) memakai Anonymous auth, rate limit, dan filter kata.
  - Moderasi dan tanggapan resmi.
  - Papan aspirasi dan dukungan.
- **Tahap 4:** Curhat (chat realtime) & Butuh Bantuan.
- **Tahap 5:** Edukasi (CMS global/sekolah, beasiswa, bookmark, migrasi 50 artikel).
- **Tahap 6:**
  - Dashboard: `stats/{yyyy-mm}`, fl_chart, ekspor CSV, dashboard superadmin.
  - `flutterfire configure` platform web, lalu deploy Hosting `teman-ngadu.web.app`.
- **Tahap 7 — Rilis**
  - Migrasi produksi: 44 laporan → tiket, 50 artikel, superadmin & admin.
  - Seed Sekolah Uji Coba.
  - Deploy functions/rules/indexes; App Check.
  - AAB versionName 4.0.0 (versionCode ≥ 13) → Play Console.
- **Tutorial** lengkap aplikasi + dashboard dengan akun uji coba.

## Catatan keamanan
- Password keystore hanya ada di `android/key.properties` (gitignored).
- Service account, bila diperlukan, disimpan di `~/.config/mandu/`, di luar repo.
- Produksi masih memakai functions dan rules versi 4.0.0 (sudah diperketat). Kode MANDU 2.0 **belum di-deploy**.
