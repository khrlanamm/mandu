import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../data/stats_repository.dart';

/// Dashboard superadmin: volume lintas sekolah, tanpa isi laporan atau curhat.
class PlatformDashboardScreen extends ConsumerWidget {
  const PlatformDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(platformStatsProvider);
    final palette = context.palette;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(Routes.superadminHome),
              ),
        title: const Text('Dashboard platform'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: () => ref.invalidate(platformStatsProvider),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: AsyncValueView(
        value: stats,
        onRetry: () => ref.invalidate(platformStatsProvider),
        data: (data) => ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
          children: [
            ContentWidth(
              maxWidth: 900,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GridView.count(
                    crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 4 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: Gaps.md,
                    crossAxisSpacing: Gaps.md,
                    childAspectRatio: 1.2,
                    children: [
                      _Tile(label: 'Sekolah aktif', value: '${data.totals.activeSchools}/${data.totals.schools}', icon: Icons.apartment_rounded, tone: palette.info),
                      _Tile(label: 'Anggota aktif', value: '${data.totals.members}', icon: Icons.groups_rounded, tone: palette.success),
                      _Tile(label: 'Laporan', value: '${data.totals.tickets}', icon: Icons.campaign_rounded, tone: palette.lapor),
                      _Tile(label: 'Aspirasi', value: '${data.totals.aspirations}', icon: Icons.lightbulb_rounded, tone: palette.aspirasi),
                    ],
                  ),
                  const SizedBox(height: Gaps.xl),
                  const SectionHeader(title: 'Sekolah'),
                  const SizedBox(height: Gaps.md),
                  if (data.schools.isEmpty)
                    const EmptyState(icon: Icons.apartment_outlined, title: 'Belum ada sekolah')
                  else
                    Card(
                      child: Column(
                        children: [
                          for (final school in data.schools)
                            ListTile(
                              title: Text(school.name),
                              subtitle: Text(
                                '${school.city} · ${school.members} anggota · ${school.tickets} laporan (${school.open} berjalan) · ${school.aspirations} aspirasi',
                              ),
                              trailing: school.active
                                  ? const Icon(Icons.chevron_right_rounded)
                                  : StatusPill(label: 'Nonaktif', tone: palette.neutral),
                              onTap: () => context.go(Routes.superadminSchool(school.schoolId)),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: Gaps.lg),
                  Text(
                    'Dashboard ini hanya menampilkan jumlah. Isi laporan, curhat, dan permintaan bantuan tetap tersimpan di sekolah masing-masing.',
                    style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.value, required this.icon, required this.tone});

  final String label;
  final String value;
  final IconData icon;
  final ToneColors tone;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(Radii.lg)),
      child: Padding(
        padding: const EdgeInsets.all(Gaps.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: tone.main, size: 20),
            const Spacer(),
            Text(value, style: context.textStyles.headlineMedium?.copyWith(color: tone.onContainer)),
            Text(label, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textStyles.labelMedium?.copyWith(color: tone.onContainer)),
          ],
        ),
      ),
    );
  }
}
