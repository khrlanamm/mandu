import 'package:go_router/go_router.dart';

import '../../core/domain/roles.dart';
import 'presentation/import_students_screen.dart';
import 'presentation/invite_staff_screen.dart';
import 'presentation/member_approvals_screen.dart';
import 'presentation/member_detail_screen.dart';
import 'presentation/members_screen.dart';
import 'presentation/school_settings_screen.dart';

/// Sub-rute pengelolaan sekolah; dipasang di tab Sekolah (admin) dan konsol superadmin.
List<RouteBase> schoolAdminRoutes(String Function(GoRouterState state) schoolIdOf) => [
      GoRoute(
        path: 'persetujuan',
        builder: (context, state) => MemberApprovalsScreen(schoolId: schoolIdOf(state)),
      ),
      GoRoute(
        path: 'anggota',
        builder: (context, state) => MembersScreen(schoolId: schoolIdOf(state)),
        routes: [
          GoRoute(
            path: ':uid',
            builder: (context, state) => MemberDetailScreen(schoolId: schoolIdOf(state), uid: state.pathParameters['uid']!),
          ),
        ],
      ),
      GoRoute(
        path: 'undang',
        builder: (context, state) => InviteStaffScreen(
          schoolId: schoolIdOf(state),
          initialRole: SchoolRole.tryParse(state.uri.queryParameters['peran']),
        ),
      ),
      GoRoute(
        path: 'impor',
        builder: (context, state) => ImportStudentsScreen(schoolId: schoolIdOf(state)),
      ),
      GoRoute(
        path: 'pengaturan',
        builder: (context, state) => SchoolSettingsScreen(schoolId: schoolIdOf(state)),
      ),
    ];
