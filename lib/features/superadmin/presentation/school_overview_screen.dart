import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes.dart';
import '../../../core/design/widgets/states.dart';
import '../../school_admin/presentation/school_management_view.dart';
import '../../schools/data/school_repository.dart';

class SchoolOverviewScreen extends ConsumerWidget {
  const SchoolOverviewScreen({super.key, required this.schoolId});

  final String schoolId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final school = ref.watch(schoolDocProvider(schoolId));
    return Scaffold(
      appBar: AppBar(title: Text(school.value?.name ?? 'Sekolah')),
      body: AsyncValueView(
        value: school,
        onRetry: () => ref.invalidate(schoolDocProvider(schoolId)),
        data: (school) => school == null
            ? const EmptyState(icon: Icons.apartment_rounded, title: 'Sekolah tidak ditemukan')
            : SchoolManagementView(
                school: school,
                basePath: Routes.superadminSchool(schoolId),
                canManage: true,
                superadmin: true,
              ),
      ),
    );
  }
}
