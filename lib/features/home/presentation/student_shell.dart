import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/widgets/layout.dart';
import '../../notifications/data/notification_repository.dart';

class StudentShell extends ConsumerWidget {
  const StudentShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveShell(
      shell: shell,
      destinations: [
        const ShellDestination(label: 'Beranda', icon: Icons.home_outlined, selectedIcon: Icons.home_rounded),
        const ShellDestination(label: 'Aktivitas', icon: Icons.receipt_long_outlined, selectedIcon: Icons.receipt_long_rounded),
        ShellDestination(
          label: 'Notifikasi',
          icon: Icons.notifications_none_rounded,
          selectedIcon: Icons.notifications_rounded,
          badge: ref.watch(unreadNotificationCountProvider),
        ),
        const ShellDestination(label: 'Akun', icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded),
      ],
    );
  }
}
