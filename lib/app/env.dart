/// Konfigurasi build lewat `--dart-define`.
abstract final class Env {
  /// `--dart-define=MANDU_EMULATOR=true` menghubungkan aplikasi ke Firebase Emulator Suite.
  static const useEmulators = bool.fromEnvironment('MANDU_EMULATOR');

  /// Host Emulator Suite. Kosong = 10.0.2.2 (emulator Android) atau localhost.
  static const emulatorHost = String.fromEnvironment('MANDU_EMULATOR_HOST');

  static const functionsRegion = 'us-central1';

  /// OAuth client tipe Web milik project Firebase `teman-ngadu`.
  static const googleServerClientId = '1073500398955-ag1crfrdvosk42rphshbkh0h0u1gbkev.apps.googleusercontent.com';

  /// Harus sama dengan NISN_EMAIL_DOMAIN di functions/src/core/ids.ts.
  static const nisnEmailDomain = 'nisn.teman-ngadu.web.app';

  static const webBaseUrl = 'https://teman-ngadu.web.app';

  /// Harus sama dengan `version` di pubspec.yaml.
  static const appVersion = '4.0.0';
}
