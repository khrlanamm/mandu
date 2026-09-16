# Temuan bug MANDU 2.0 dan perbaikannya

Catatan bug yang ditemukan saat mencoba aplikasi di emulator Android, menulis tes, dan menyusun manual
penggunaan. Setiap temuan dicatat beserta penyebab, perbaikan, dan cara memastikannya tidak kembali.

| # | Temuan | Penyebab | Perbaikan | Pencegahan |
|---|---|---|---|---|
| 1 | APK debug gagal dipasang di emulator (`INSTALL_FAILED_INSUFFICIENT_STORAGE`), kadang tanpa pesan sehingga aplikasi lama tetap berjalan dan perbaikan terlihat "tidak berfungsi" | APK debug universal ±200 MB dan penyimpanan emulator hampir penuh; `adb install -r` bisa gagal senyap | Build `--split-per-abi --target-platform android-arm64` (±70 MB); `adb uninstall` dulu, lalu `adb install` tanpa `\| tail -1`, dan cocokkan `dumpsys package ... lastUpdateTime` dengan waktu berkas APK | Langkah verifikasi dicantumkan di `docs/mandu-2.0-progress.md` |
| 2 | **Tombol Tolak / Minta data / Teruskan menutupi seluruh layar** di detail laporan staf (menimpa status bar) | `ContentWidth` memakai `Align` tanpa `heightFactor`; di `bottomNavigationBar` batas tingginya setinggi layar, sehingga bar ikut setinggi layar | Bar aksi memakai `Align(heightFactor: 1)` + `ConstrainedBox` | Bottom bar lain (pengaturan sekolah, persetujuan siswa, editor Edukasi) diperiksa: memakai `SafeArea` biasa, aman |
| 3 | **Draf artikel Edukasi terbaca siswa** | Rules lama aplikasi 4.0.0 `match /articles/{id} { allow read: if signedIn(); }` masih ada dan di-OR dengan aturan baru | Aturan lama dihapus, aturan baru: hanya `published == true` atau superadmin | Tes rules `education-rules.test.ts` menguji draf, daftar tanpa filter, dan artikel sekolah |
| 4 | Artikel lama (50 artikel aplikasi 4.0.0) tidak punya field `published`, sehingga `resource.data.published` error dan artikel tidak terbaca | Dokumen lama belum dimigrasi | Migrasi tahap 7 wajib menambahkan `published: true`; tes legacy menegaskan artikel tanpa field itu tidak terbaca | Tes `firestore-rules.test.ts` (blok legacy) |
| 5 | Keluar akun tertahan di emulator (aplikasi diam setelah menekan "Keluar") | `GoogleSignIn.signOut()` (Credential Manager) tidak merespons di emulator, dan dipanggil walau pengguna masuk lewat email/NISN | Google sign-out hanya dipanggil bila akun memakai penyedia Google, plus batas waktu 5 detik; pelepasan token FCM juga diberi batas waktu | — |
| 6 | Kartu layanan Curhat, Aspirasi, Butuh Bantuan, dan Edukasi hanya menampilkan pesan "sedang disiapkan" | Layar terkait memang belum ada saat tahap 2 | Semua layanan sudah tersambung ke layarnya; `switch` di beranda siswa kini lengkap tanpa `default` | Analyzer menandai `unreachable_switch_default` bila ada layanan baru yang lupa dipetakan |
| 7 | **Keluar akun gagal total** — aplikasi tetap masuk sebagai pengguna lama setelah menekan "Keluar" | Dependensi melingkar Riverpod: `SessionController.signOut()` membaca `pushControllerProvider`, sedangkan `PushController` mendengarkan `sessionControllerProvider`. Riverpod melempar "provider depends on itself" sebelum `FirebaseAuth.signOut()` sempat dipanggil | Pelepasan token FCM dipindah ke fungsi bantu `signOutFromApp(ref)` di lapisan UI, sehingga tidak ada provider yang saling bergantung | Dicek ulang di emulator: keluar akun dari siswa, staf, dan superadmin |
| 8 | Dashboard sekolah gagal dengan pesan `NOT_FOUND` saat diuji di emulator | Callable `stats-school`/`stats-platform` baru ditambahkan, tetapi `functions` belum di-build ulang sehingga Emulator Suite masih memuat kode lama | `npm --prefix functions run build` setiap kali menambah callable; emulator memuat ulang otomatis | Langkah build dicantumkan di `docs/mandu-2.0-progress.md` bagian "Cara menjalankan" |
| 9 | Dry-run migrasi melaporkan tiket "akan dibuat" walau laporan itu sudah dimigrasi | Pengecekan dokumen tiket yang sudah ada hanya dijalankan saat mode `--apply` | Pengecekan dilakukan di kedua mode, sehingga ringkasan dry-run menggambarkan keadaan sebenarnya sebelum dijalankan di produksi | Dry-run dijalankan dua kali di emulator: laporan kedua menampilkan "tiket sudah dimigrasi" |
| 10 | Deploy Cloud Functions ke produksi gagal untuk semua fungsi, padahal sebagian besar sudah terpasang | Satu fungsi (`curhatMessageCreated`) sudah ada di produksi dengan tipe HTTPS, sedangkan versi baru memakai trigger Firestore. Firebase menolak perubahan tipe dan menggagalkan seluruh rilis | Hapus fungsi itu (`firebase functions:delete curhatMessageCreated --region us-central1`) lalu deploy ulang | Jalankan `firebase deploy --only functions` tanpa memotong keluarannya; pesan sebabnya hanya muncul sekali di antara daftar "Failed to create function" |

## Pemeriksaan lain yang sudah dilakukan

- **Rules yang tumpang tindih:** seluruh blok `match` di `firestore.rules` ditelusuri. Selain `articles`,
  koleksi lama (`reports`, `admins`) tidak beririsan dengan koleksi MANDU 2.0.
- **Kerahasiaan identitas:** tes rules memastikan identitas pelapor (`ticketOwners`), pengirim aspirasi
  (`aspirations/{id}/private`), dan siswa yang memakai nama samaran di Curhat tidak terbaca pihak lain.
- **Akses lintas sekolah:** tes rules memakai sekolah kedua untuk memastikan data sekolah A tidak terbaca
  anggota sekolah B.
- **Notifikasi perangkat (FCM):** sesuai permintaan, pengujian push di perangkat nyata dilakukan terpisah;
  registrasi token dan kotak masuk notifikasi sudah diuji di emulator.
