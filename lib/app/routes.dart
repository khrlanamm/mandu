abstract final class Routes {
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const nisnLogin = '/login/nisn';
  static const emailLogin = '/login/email';

  static const consent = '/onboarding/consent';
  static const changePassword = '/onboarding/password';
  static const join = '/onboarding/join';
  static const pending = '/onboarding/pending';

  /// Profil untuk pengguna yang belum punya shell (mis. menunggu persetujuan).
  static const account = '/account';

  static const studentHome = '/home';
  static const studentActivity = '/home/aktivitas';
  static const studentNotifications = '/home/notifikasi';
  static const studentAccount = '/home/akun';

  static const staffHome = '/staff';
  static const staffTasks = '/staff/tugas';
  static const staffSchool = '/staff/sekolah';
  static const staffAccount = '/staff/akun';

  static const superadminHome = '/superadmin';
  static const superadminNewSchool = '/superadmin/sekolah/baru';
  static const superadminAccount = '/superadmin/akun';

  static String superadminSchool(String schoolId) => '/superadmin/sekolah/$schoolId';
}
