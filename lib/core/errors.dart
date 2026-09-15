import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Error dengan pesan yang aman ditampilkan ke pengguna.
class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

const _offline = 'Tidak ada koneksi ke server. Periksa internetmu lalu coba lagi.';

/// Pesan error dalam Bahasa Indonesia untuk ditampilkan di UI.
String describeError(Object error) {
  return switch (error) {
    AppException(:final message) => message,
    FirebaseFunctionsException(:final code, :final message) => switch (code) {
        'unavailable' || 'deadline-exceeded' => _offline,
        _ => (message == null || message.isEmpty) ? 'Terjadi kesalahan pada server.' : message,
      },
    FirebaseAuthException(:final code) => _authMessage(code),
    FirebaseException(:final code, :final message) => switch (code) {
        'permission-denied' => 'Kamu tidak memiliki akses untuk data ini.',
        'unavailable' => _offline,
        _ => message ?? 'Terjadi kesalahan ($code).',
      },
    _ => 'Terjadi kesalahan. Coba lagi.',
  };
}

String _authMessage(String code) => switch (code) {
      'invalid-credential' || 'wrong-password' || 'user-not-found' || 'invalid-email' =>
        'Data masuk tidak cocok. Periksa kembali lalu coba lagi.',
      'user-disabled' => 'Akun ini dinonaktifkan. Hubungi admin sekolah.',
      'too-many-requests' => 'Terlalu banyak percobaan. Tunggu beberapa menit lalu coba lagi.',
      'network-request-failed' => _offline,
      'account-exists-with-different-credential' => 'Email ini sudah terdaftar dengan cara masuk lain.',
      'requires-recent-login' => 'Demi keamanan, silakan masuk ulang lalu coba lagi.',
      _ => 'Gagal masuk ($code).',
    };
