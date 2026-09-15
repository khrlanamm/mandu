# MANDU 2.0 — Catatan Progres & Serah Terima

Rencana lengkap yang sudah disetujui: `/Users/benevology/.claude/plans/snuggly-gathering-gosling.md`
Branch kerja: `mandu-2.0` (jangan kerjakan di `master`).

## Selesai

**Tahap 0 — Fondasi**
- Logo MANDU 2.0 konsep A "Suara Siswa" dipilih user. Sumber: `design/logo/*.svg`. Semua ikon Android/web dibuat ulang lewat `tool/brand/generate.sh`.
- Flutter SDK 3.47.4 (Dart 3.13.3), dipasang lewat Homebrew. Platform web aktif.
- Font Plus Jakarta Sans statis di `assets/fonts` sudah terdaftar di pubspec.
- Dependency pubspec sudah ditambah: Riverpod 3 + generator, go_router 18, freezed 4, json_serializable, fl_chart, dll.
- Cloud Functions ditulis ulang dalam TypeScript (`functions/`): firebase-functions v7, firebase-admin v14, zod v4, vitest.
  - Commit `a09639c`.

**Tahap 1 — Backend multi-sekolah** (commit `3f29808`)
- Callable functions:
  - `account-*`: sync, acceptConsent, changeInitialPassword, updateDisplayName;
  - `schools-*`: lookup, create, update, changeCode;
  - `members-*`: join, cancelJoin, review, update, remove, invite, revokeInvitation, importStudents, resetStudentPassword.
- Rules dan index Firestore multi-sekolah. Rules legacy aplikasi 4.0.0 masih dipertahankan.
- 24 tes emulator lulus: `cd functions && npm run test:emulator` (butuh `PATH=/opt/homebrew/opt/openjdk@21/bin:$PATH`).
- Custom claims: `{sa}` untuk superadmin; `{sid, role, units[], canVerify}` untuk anggota aktif sekolah.
- Email akun NISN: `{schoolId}.{nisn}@nisn.teman-ngadu.web.app`.
- **Belum di-deploy** ke produksi. Produksi masih memakai functions dan rules versi 4.0.0.

## Sedang dikerjakan (WIP, belum bisa di-compile)

Fondasi aplikasi Flutter, gelombang A. Kode lama v4 di `lib/` sudah dihapus.

**Sudah ditulis**
- `lib/main.dart`
- `lib/app/`: env, bootstrap (emulator via `--dart-define=MANDU_EMULATOR=true`), app, routes, redirect, router (go_router + Riverpod codegen)
- `lib/core/design/`: tokens, palette (ThemeExtension warna 5 layanan + status), theme, assets
- `lib/core/design/widgets/`: mandu_logo, states (Loading/Empty/Error/AsyncValueView), feedback (showSnack, confirmAction, runGuarded, ButtonSpinner), layout (ContentWidth, SectionHeader, InfoBanner, StatusPill, AdaptiveShell)
- `lib/core/domain/`: roles (SchoolRole, AccountStatus), service (ManduService)

**Belum ditulis (gelombang A)**
- `lib/core/errors.dart`: `AppException`, `describeError(Object)` untuk memetakan error Functions/Auth/Firestore ke pesan bahasa Indonesia.
- `lib/core/domain/catalog.dart`: `kConsentVersion = '2026-09'`, salinan katalog kategori dari `functions/src/domain/catalog.ts`.
- `lib/core/domain/school_code.dart`: `parseSchoolCode(String?)`, menerima kode atau URL `https://teman-ngadu.web.app/s/{KODE}`.
- `lib/core/firebase/`:
  - `firebase_providers.dart`: firebaseAuthProvider, firestoreProvider, functionsProvider (region us-central1), storageProvider;
  - `callable.dart`: extension `callMap(name, data)` + `jsonMap`.
- `lib/features/account/`:
  - `domain/account_summary.dart`: freezed; field sesuai `AccountSummary` di `functions/src/accounts/sync.ts`; getter `isActiveMember`;
  - `data/account_repository.dart`.
- `lib/features/auth/`:
  - `data/auth_repository.dart`: Google via Credential Manager (web: signInWithPopup), NISN, email, signOut;
  - `application/session_controller.dart`: sealed `Session` (SessionLoading, SignedOut, SessionFailure, SignedIn(account)), `SessionController` (keepAlive; memantau authStateChanges dan `users/{uid}.claimsVersion` → refresh token + sync), `currentAccountProvider`;
  - `presentation/`: splash, welcome, nisn_login, email_login (daftar akun demo bila memakai emulator).
- `lib/features/onboarding/presentation/`: consent, change_password, join_school (kode + scan QR), pending (termasuk alasan ditolak), qr_scan (mobile_scanner).
- `lib/features/schools/`: `domain/public_school.dart` (freezed), `data/school_repository.dart`.
- `lib/features/members/data/membership_repository.dart`.

**Gelombang B** (dirujuk oleh `lib/app/router.dart`)
- `lib/features/home/presentation/`: student_shell, student_home_screen (5 pintu layanan), staff_shell, staff_home_screen, placeholder_screen (`.activity()`, `.notifications()`, `.tasks()`).
- `lib/features/profile/presentation/profile_screen.dart`.
- `lib/features/school_admin/`:
  - `school_admin_routes.dart`: `schoolAdminRoutes(String Function(GoRouterState) schoolIdOf)` dengan sub-rute persetujuan, anggota, `anggota/:uid`, undang, impor, pengaturan;
  - `presentation/`: school_tab_screen, member_approvals, members, member_detail, invite_staff, import_students (CSV), school_settings (kode + QR).
- `lib/features/superadmin/presentation/`: superadmin_shell, superadmin_schools_screen, create_school_screen, school_overview_screen.
- Setelah itu: `dart run build_runner build -d`, `flutter analyze`, unit test `resolveRedirect`, lalu jalankan di emulator Android dengan Emulator Suite.

## Permintaan tambahan dari user (16 Sep 2026)

1. **Sekolah dan akun testing.** Buat skrip seed `functions/scripts/seed.ts` untuk emulator dan untuk produksi ("Sekolah Uji Coba MANDU").
   - Rencana akun demo (password `mandu123`):
     - `superadmin@mandu.test`;
     - SMA Negeri Demo, kode `DEMO01`: `admin@smandemo.sch.id` (admin), `kepsek@smandemo.sch.id` (pimpinan), `bk@smandemo.sch.id` (konselor, unit bk_ppks), `sarpras@smandemo.sch.id` (petugas sarpras), `siswa@smandemo.sch.id` (siswa aktif), `calon.siswa@mandu.test` (menunggu persetujuan);
     - satu akun NISN;
     - SMP Harapan, kode `HARAPAN`: `admin@smpharapan.sch.id`.
2. **Tutorial lengkap** aplikasi dan dashboard dengan akun-akun tersebut, di akhir.
3. **Dashboard web di Firebase Hosting** (`teman-ngadu.web.app`). Butuh `flutterfire configure` untuk platform web.
4. **Upload ke Play Console** di akhir dengan versionName **4.0.0** (versionCode 13 belum pernah di-upload; pakai ≥ 13).
   - Upload key di `android/key.properties`.
   - Sebelum upload, migrasi data produksi (tahap 7) harus sudah selesai.

## Tahap berikutnya sesuai rencana

- 2 — Lapor end-to-end
- 3 — Aspirasi (termasuk tanpa login)
- 4 — Curhat & Butuh Bantuan
- 5 — Edukasi
- 6 — Dashboard & web
- 7 — Migrasi produksi, App Check, rilis
