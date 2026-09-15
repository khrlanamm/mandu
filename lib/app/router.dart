import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/application/session_controller.dart';
import '../features/auth/presentation/email_login_screen.dart';
import '../features/auth/presentation/nisn_login_screen.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/auth/presentation/welcome_screen.dart';
import '../features/home/presentation/placeholder_screen.dart';
import '../features/home/presentation/staff_home_screen.dart';
import '../features/home/presentation/staff_shell.dart';
import '../features/home/presentation/student_home_screen.dart';
import '../features/home/presentation/student_shell.dart';
import '../features/onboarding/presentation/change_password_screen.dart';
import '../features/onboarding/presentation/consent_screen.dart';
import '../features/onboarding/presentation/join_school_screen.dart';
import '../features/onboarding/presentation/pending_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/school_admin/presentation/school_tab_screen.dart';
import '../features/school_admin/school_admin_routes.dart';
import '../features/superadmin/presentation/create_school_screen.dart';
import '../features/superadmin/presentation/school_overview_screen.dart';
import '../features/superadmin/presentation/superadmin_schools_screen.dart';
import '../features/superadmin/presentation/superadmin_shell.dart';
import 'redirect.dart';
import 'routes.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final session = ValueNotifier<Session>(ref.read(sessionControllerProvider));
  ref.listen<Session>(sessionControllerProvider, (_, next) => session.value = next);

  String currentSchoolId() => switch (session.value) {
        SignedIn(:final account) => account.schoolId ?? '',
        _ => '',
      };

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: session,
    redirect: (context, state) => resolveRedirect(session.value, state.uri),
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.welcome, builder: (context, state) => const WelcomeScreen()),
      GoRoute(
        path: Routes.nisnLogin,
        builder: (context, state) => NisnLoginScreen(initialCode: state.uri.queryParameters['kode']),
      ),
      GoRoute(path: Routes.emailLogin, builder: (context, state) => const EmailLoginScreen()),
      GoRoute(path: Routes.consent, builder: (context, state) => const ConsentScreen()),
      GoRoute(path: Routes.changePassword, builder: (context, state) => const ChangePasswordScreen()),
      GoRoute(
        path: Routes.join,
        builder: (context, state) => JoinSchoolScreen(initialCode: state.uri.queryParameters['kode']),
      ),
      GoRoute(path: Routes.pending, builder: (context, state) => const PendingScreen()),
      GoRoute(path: Routes.account, builder: (context, state) => const ProfileScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => StudentShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.studentHome, builder: (context, state) => const StudentHomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.studentActivity, builder: (context, state) => const PlaceholderScreen.activity()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.studentNotifications, builder: (context, state) => const PlaceholderScreen.notifications()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.studentAccount, builder: (context, state) => const ProfileScreen()),
          ]),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => StaffShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.staffHome, builder: (context, state) => const StaffHomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.staffTasks, builder: (context, state) => const PlaceholderScreen.tasks()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.staffSchool,
              builder: (context, state) => SchoolTabScreen(schoolId: currentSchoolId()),
              routes: schoolAdminRoutes((state) => currentSchoolId()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.staffAccount, builder: (context, state) => const ProfileScreen()),
          ]),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => SuperadminShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.superadminHome,
              builder: (context, state) => const SuperadminSchoolsScreen(),
              routes: [
                GoRoute(path: 'sekolah/baru', builder: (context, state) => const CreateSchoolScreen()),
                GoRoute(
                  path: 'sekolah/:schoolId',
                  builder: (context, state) => SchoolOverviewScreen(schoolId: state.pathParameters['schoolId']!),
                  routes: schoolAdminRoutes((state) => state.pathParameters['schoolId']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.superadminAccount, builder: (context, state) => const ProfileScreen()),
          ]),
        ],
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    session.dispose();
  });
  return router;
}
