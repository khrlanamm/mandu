/// Konfigurasi statis aplikasi Mandu.
abstract final class AppConstants {
  /// OAuth client bertipe Web (client_type 3) milik project Firebase `teman-ngadu`.
  /// Credential Manager memakainya untuk menerbitkan ID token yang diterima Firebase Auth.
  static const googleServerClientId =
      '1073500398955-ag1crfrdvosk42rphshbkh0h0u1gbkev.apps.googleusercontent.com';

  static const functionsRegion = 'us-central1';

  static const counselingWhatsApp = '+6285731774570';
  static const counselingName = 'Bimbingan Konseling SMAN 1 Sukodadi';

  /// Harus sama dengan `default_notification_channel_id` di AndroidManifest.xml.
  static const notificationChannelId = 'mandu_channel';
  static const notificationChannelName = 'Mandu Notifications';

  static const reportFrequencies = [
    'Pertama Kali',
    'Beberapa Kali',
    'Sering',
    'Sangat Sering',
    'Setiap Hari',
  ];
}
