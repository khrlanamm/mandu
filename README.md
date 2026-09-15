# Mandu – Teman Ngadu

Aplikasi pelaporan bullying (LaBu) untuk SMAN 1 Sukodadi. Versi 4 ditulis ulang dengan
**Flutter**. Package, listing Play Store, dan backend Firebase tetap sama dengan versi Kotlin.

| | |
|---|---|
| Application ID | `com.khrlanamm.mandu` |
| Firebase project | `teman-ngadu` |
| Versi Kotlin terakhir | branch `kotlin-legacy`, tag `v3.0.0-kotlin` (versionCode 12) |

## Fitur

- Login Google (Firebase Auth + Credential Manager)
- Beranda: artikel edukasi (Firestore `articles`) dengan pencarian
- Formulir LaBu: laporan korban/saksi + bukti foto (Firestore `reports`, Storage `laporan_bukti/`)
- Riwayat laporan dengan filter tanggal/status dan statistik
- Admin (`admins/{uid}`): lihat semua laporan, ubah status, hubungi pelapor via WhatsApp
- Notifikasi FCM ke admin lewat Cloud Function `sendReportNotification` (us-central1)

## Setup di mesin baru

```bash
flutter pub get

# File konfigurasi Firebase tidak di-commit; buat ulang:
dart pub global activate flutterfire_cli
flutterfire configure --project=teman-ngadu --platforms=android \
  --android-package-name=com.khrlanamm.mandu --yes

flutter run
```

Google Sign-In butuh SHA-1 dan SHA-256 dari keystore yang dipakai build, terdaftar di Firebase
(Project settings → Your apps → Android). Untuk debug key di mesin baru:

```bash
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android
firebase apps:android:sha:create 1:1073500398955:android:8abf2054efa290ea78182e <SHA> --project teman-ngadu
```

## Rilis ke Play Console

1. Salin `android/key.properties.example` menjadi `android/key.properties`, lalu isi path dan password
   upload keystore. Simpan keystore di luar repo.
2. Naikkan `version` di `pubspec.yaml`. Angka setelah `+` adalah versionCode dan harus lebih besar
   dari rilis sebelumnya.
3. `flutter build appbundle --release`, lalu upload `build/app/outputs/bundle/release/app-release.aab`.

Play App Signing aktif, jadi build dari Play Store ditandatangani kunci Google. SHA kunci itu
sudah terdaftar di Firebase.

## Struktur

```
lib/
  core/        tema, konstanta, util, widget bersama
  data/        model & repository Firestore/Storage/Functions/Auth
  services/    notifikasi (FCM + local notifications)
  features/    auth, home, article, report, history, detail, profile
firestore.rules, storage.rules   security rules (firebase deploy --only firestore:rules,storage)
```
