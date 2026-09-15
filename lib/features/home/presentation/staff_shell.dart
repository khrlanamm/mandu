import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/widgets/layout.dart';
import '../../lapor/data/ticket_repository.dart';

class StaffShell extends ConsumerWidget {
  const StaffShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveShell(
      shell: shell,
      destinations: [
        const ShellDestination(label: 'Beranda', icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard_rounded),
        ShellDestination(
          label: 'Tugas',
          icon: Icons.task_alt_outlined,
          selectedIcon: Icons.task_alt_rounded,
          badge: ref.watch(staffActionableCountProvider),
        ),
        const ShellDestination(label: 'Sekolah', icon: Icons.apartment_outlined, selectedIcon: Icons.apartment_rounded),
        const ShellDestination(label: 'Akun', icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded),
      ],
    );
  }
}
