import '../core/domain/roles.dart';
import '../features/account/domain/account_summary.dart';
import '../features/auth/application/session_controller.dart';
import 'routes.dart';

/// Rute utama sesuai status akun dan peran.
String homeRouteFor(AccountSummary account) {
  if (account.isActiveMember) {
    return account.role == SchoolRole.siswa ? Routes.studentHome : Routes.staffHome;
  }
  if (account.isSuperadmin) return Routes.superadminHome;
  return switch (account.status) {
    AccountStatus.pending || AccountStatus.rejected => Routes.pending,
    _ => Routes.join,
  };
}

/// Halaman tanpa login (aspirasi publik lewat kode/QR sekolah).
const _publicPrefixes = ['/s'];

String? resolveRedirect(Session session, Uri uri) {
  final path = uri.path;
  bool under(String prefix) => path == prefix || path.startsWith('$prefix/');

  if (_publicPrefixes.any(under)) return null;

  return switch (session) {
    SessionLoading() || SessionFailure() => path == Routes.splash ? null : Routes.splash,
    SignedOut() => under(Routes.welcome) || under('/login') ? null : Routes.welcome,
    SignedIn(:final account) => _signedInRedirect(account, path, under),
  };
}

String? _signedInRedirect(AccountSummary account, String path, bool Function(String) under) {
  if (account.needsConsent) return path == Routes.consent ? null : Routes.consent;
  if (account.mustChangePassword) return path == Routes.changePassword ? null : Routes.changePassword;

  final home = homeRouteFor(account);
  final allowed = [
    home,
    Routes.account,
    if (account.isSuperadmin) Routes.superadminHome,
    // Permintaan ditolak: siswa boleh mengajukan ulang.
    if (home == Routes.pending) Routes.join,
  ];
  return allowed.any(under) ? null : home;
}
