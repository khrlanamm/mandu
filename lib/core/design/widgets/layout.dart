import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../palette.dart';
import '../tokens.dart';
import 'mandu_logo.dart';

/// Membatasi lebar konten di layar lebar dan memberi padding standar.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.maxWidth = kContentMaxWidth});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth), child: child),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: context.textStyles.titleMedium)),
        ?action,
      ],
    );
  }
}

class InfoBanner extends StatelessWidget {
  const InfoBanner({super.key, required this.icon, required this.message, this.tone, this.title});

  final IconData icon;
  final String message;
  final String? title;
  final ToneColors? tone;

  @override
  Widget build(BuildContext context) {
    final colors = tone ?? context.palette.info;
    return DecoratedBox(
      decoration: BoxDecoration(color: colors.container, borderRadius: BorderRadius.circular(Radii.md)),
      child: Padding(
        padding: const EdgeInsets.all(Gaps.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.main, size: 22),
            const SizedBox(width: Gaps.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(title!, style: context.textStyles.titleSmall?.copyWith(color: colors.onContainer)),
                    ),
                  Text(message, style: context.textStyles.bodyMedium?.copyWith(color: colors.onContainer)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Label kecil berwarna untuk status/peran.
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.tone, this.icon});

  final String label;
  final ToneColors tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(999)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 14, color: tone.main), const SizedBox(width: 4)],
            Text(label, style: context.textStyles.labelSmall?.copyWith(color: tone.onContainer)),
          ],
        ),
      ),
    );
  }
}

class ShellDestination {
  const ShellDestination({required this.label, required this.icon, required this.selectedIcon, this.badge = 0});

  final String label;
  final IconData icon;
  final IconData selectedIcon;

  /// Angka pada ikon (mis. notifikasi belum dibaca). 0 = tanpa badge.
  final int badge;

  Widget buildIcon({required bool selected}) {
    final icon = Icon(selected ? selectedIcon : this.icon);
    if (badge <= 0) return icon;
    return Badge(label: Text(badge > 99 ? '99+' : '$badge'), child: icon);
  }
}

/// Navigasi bawah di HP, NavigationRail di tablet/web.
class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({super.key, required this.shell, required this.destinations});

  final StatefulNavigationShell shell;
  final List<ShellDestination> destinations;

  void _select(int index) => shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= kWideLayoutBreakpoint) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: shell.currentIndex,
                  onDestinationSelected: _select,
                  labelType: NavigationRailLabelType.all,
                  leading: const Padding(
                    padding: EdgeInsets.only(top: Gaps.md, bottom: Gaps.xl),
                    child: ManduLogo(size: 36, showWordmark: false),
                  ),
                  destinations: [
                    for (final destination in destinations)
                      NavigationRailDestination(
                        icon: destination.buildIcon(selected: false),
                        selectedIcon: destination.buildIcon(selected: true),
                        label: Text(destination.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: shell),
              ],
            ),
          );
        }
        return Scaffold(
          body: shell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: _select,
            destinations: [
              for (final destination in destinations)
                NavigationDestination(
                  icon: destination.buildIcon(selected: false),
                  selectedIcon: destination.buildIcon(selected: true),
                  label: destination.label,
                ),
            ],
          ),
        );
      },
    );
  }
}
