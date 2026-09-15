import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/widgets/layout.dart';

class StudentShell extends StatelessWidget {
  const StudentShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveShell(
      shell: shell,
      destinations: const [
        ShellDestination(label: 'Beranda', icon: Icons.home_outlined, selectedIcon: Icons.home_rounded),
        ShellDestination(label: 'Aktivitas', icon: Icons.receipt_long_outlined, selectedIcon: Icons.receipt_long_rounded),
        ShellDestination(label: 'Notifikasi', icon: Icons.notifications_none_rounded, selectedIcon: Icons.notifications_rounded),
        ShellDestination(label: 'Akun', icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded),
      ],
    );
  }
}
