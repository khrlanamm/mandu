import 'package:flutter_test/flutter_test.dart';
import 'package:mandu/app/redirect.dart';
import 'package:mandu/app/routes.dart';
import 'package:mandu/core/domain/roles.dart';
import 'package:mandu/features/account/domain/account_summary.dart';
import 'package:mandu/features/auth/application/session_controller.dart';

AccountSummary _account({
  AccountStatus status = AccountStatus.active,
  SchoolRole? role = SchoolRole.siswa,
  bool needsConsent = false,
  bool mustChangePassword = false,
  bool isSuperadmin = false,
}) {
  return AccountSummary(
    uid: 'u1',
    displayName: 'Budi Santoso',
    status: status,
    schoolId: status == AccountStatus.none ? null : 'sekolah-a',
    schoolName: status == AccountStatus.none ? null : 'Sekolah A',
    role: status == AccountStatus.none ? null : role,
    needsConsent: needsConsent,
    mustChangePassword: mustChangePassword,
    isSuperadmin: isSuperadmin,
  );
}

String? _redirect(Session session, String path) => resolveRedirect(session, Uri.parse(path));

void main() {
  test('belum masuk diarahkan ke halaman awal, kecuali login dan aspirasi publik', () {
    expect(_redirect(const SignedOut(), Routes.studentHome), Routes.welcome);
    expect(_redirect(const SignedOut(), Routes.nisnLogin), isNull);
    expect(_redirect(const SignedOut(), '/s/DEMO01/aspirasi'), isNull);
  });

  test('sesi yang sedang dimuat atau gagal menampilkan splash', () {
    expect(_redirect(const SessionLoading(), Routes.staffHome), Routes.splash);
    expect(_redirect(const SessionLoading(), Routes.splash), isNull);
    expect(_redirect(const SessionFailure('offline'), Routes.studentHome), Routes.splash);
  });

  test('persetujuan privasi lalu ganti password awal didahulukan', () {
    expect(_redirect(SignedIn(_account(needsConsent: true, mustChangePassword: true)), Routes.studentHome), Routes.consent);
    expect(_redirect(SignedIn(_account(mustChangePassword: true)), Routes.studentHome), Routes.changePassword);
    expect(_redirect(SignedIn(_account()), Routes.consent), Routes.studentHome);
  });

  test('siswa aktif ke beranda siswa, staf ke beranda staf', () {
    expect(_redirect(SignedIn(_account()), Routes.splash), Routes.studentHome);
    expect(_redirect(SignedIn(_account()), Routes.staffHome), Routes.studentHome);
    expect(_redirect(SignedIn(_account(role: SchoolRole.konselor)), Routes.welcome), Routes.staffHome);
    expect(_redirect(SignedIn(_account(role: SchoolRole.admin)), '${Routes.staffSchool}/anggota/u2'), isNull);
    expect(_redirect(SignedIn(_account(role: SchoolRole.admin)), Routes.superadminHome), Routes.staffHome);
  });

  test('akun tanpa sekolah, menunggu, dan ditolak', () {
    expect(_redirect(SignedIn(_account(status: AccountStatus.none)), Routes.studentHome), Routes.join);
    expect(_redirect(SignedIn(_account(status: AccountStatus.pending)), Routes.studentHome), Routes.pending);
    expect(_redirect(SignedIn(_account(status: AccountStatus.pending)), Routes.account), isNull);
    expect(_redirect(SignedIn(_account(status: AccountStatus.pending)), Routes.join), isNull);
    expect(_redirect(SignedIn(_account(status: AccountStatus.rejected)), Routes.join), isNull);
  });

  test('superadmin tanpa sekolah menuju konsol superadmin', () {
    final superadmin = SignedIn(_account(status: AccountStatus.none, isSuperadmin: true));
    expect(_redirect(superadmin, Routes.join), Routes.superadminHome);
    expect(_redirect(superadmin, '${Routes.superadminSchool('sekolah-a')}/pengaturan'), isNull);
  });
}
