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
  static const studentReport = '/home/lapor';
  static const studentEducation = '/home/edukasi';
  static const studentBookmarks = '/home/edukasi/tersimpan';

  static String studentArticleById(String articleId, {String? schoolId}) =>
      '/home/edukasi/$articleId${schoolId == null ? '' : '?sekolah=$schoolId'}';

  static const studentHelp = '/home/bantuan';
  static const studentHelpForm = '/home/bantuan/baru';
  static const studentCurhat = '/home/curhat';
  static const studentCurhatStart = '/home/curhat/baru';

  static String studentHelpDetail(String requestId) => '/home/bantuan/$requestId';

  static String studentConversation(String conversationId) => '/home/curhat/$conversationId';

  static const studentAspirations = '/home/aspirasi';
  static const studentAspirationForm = '/home/aspirasi/baru';

  static String studentAspiration(String id, {bool justSubmitted = false}) =>
      '/home/aspirasi/$id${justSubmitted ? '?baru=1' : ''}';

  static String studentReportForm(String category) => '/home/lapor/$category';

  static String studentTicket(String ticketId, {bool justSubmitted = false}) =>
      '/home/laporan/$ticketId${justSubmitted ? '?baru=1' : ''}';

  static const staffHome = '/staff';
  static const staffTasks = '/staff/tugas';
  static const staffSchool = '/staff/sekolah';
  static const staffAccount = '/staff/akun';
  static const staffNotifications = '/staff/notifikasi';
  static const staffAspirations = '/staff/aspirasi';

  /// Ruang kerja konselor (Butuh Bantuan + Curhat).
  static const staffDashboard = '/staff/dashboard';
  static const staffCare = '/staff/bk';
  static const staffEducation = '/staff/edukasi';
  static const staffArticleNew = '/staff/edukasi/tulis';

  static String staffArticleEdit(String articleId) => '/staff/edukasi/tulis?id=$articleId';

  static String staffHelpDetail(String requestId) => '/staff/bantuan/$requestId';

  static String staffConversation(String conversationId) => '/staff/curhat/$conversationId';

  static String staffAspiration(String id) => '/staff/aspirasi/$id';

  /// Aspirasi tanpa login lewat kode/QR sekolah (web & aplikasi).
  static String publicAspiration(String code) => '/s/${code.toUpperCase()}/aspirasi';

  static String staffTicket(String ticketId) => '/staff/laporan/$ticketId';

  static const superadminHome = '/superadmin';
  static const superadminNewSchool = '/superadmin/sekolah/baru';
  static const superadminAccount = '/superadmin/akun';

  static String superadminSchool(String schoolId) => '/superadmin/sekolah/$schoolId';

  static const superadminDashboard = '/superadmin/dashboard';
  static const superadminEducation = '/superadmin/edukasi';
  static const superadminArticleNew = '/superadmin/edukasi/tulis';

  static String superadminArticleEdit(String articleId) => '/superadmin/edukasi/tulis?id=$articleId';
}
