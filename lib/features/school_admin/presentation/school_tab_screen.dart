import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/roles.dart';
import '../../auth/application/session_controller.dart';
import '../../schools/data/school_repository.dart';
import 'school_management_view.dart';

/// Tab "Sekolah" untuk staf: menu kelola (admin) atau informasi sekolah.
class SchoolTabScreen extends ConsumerWidget {
  const SchoolTabScreen({super.key, required this.schoolId});

  final String schoolId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currentAccountProvider);
    final school = ref.watch(schoolDocProvider(schoolId));
    final canManage = account?.role == SchoolRole.admin || (account?.isSuperadmin ?? false);

    return Scaffold(
      appBar: AppBar(title: const Text('Sekolah')),
      body: AsyncValueView(
        value: school,
        onRetry: () => ref.invalidate(schoolDocProvider(schoolId)),
        data: (school) => school == null
            ? const EmptyState(icon: Icons.apartment_rounded, title: 'Sekolah tidak ditemukan')
            : SchoolManagementView(school: school, basePath: Routes.staffSchool, canManage: canManage),
      ),
    );
  }
}
