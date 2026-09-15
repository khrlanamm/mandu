import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/widgets/layout.dart';

class SuperadminShell extends StatelessWidget {
  const SuperadminShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveShell(
      shell: shell,
      destinations: const [
        ShellDestination(label: 'Sekolah', icon: Icons.apartment_outlined, selectedIcon: Icons.apartment_rounded),
        ShellDestination(label: 'Akun', icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded),
      ],
    );
  }
}
