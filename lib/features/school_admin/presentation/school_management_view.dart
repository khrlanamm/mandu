import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/domain/catalog.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/school.dart';
import 'school_code_sheet.dart';

/// Ringkasan sekolah dan menu pengelolaan. [basePath] = rute induk sub-halaman admin.
class SchoolManagementView extends ConsumerWidget {
  const SchoolManagementView({
    super.key,
    required this.school,
    required this.basePath,
    required this.canManage,
    this.superadmin = false,
  });

  final School school;
  final String basePath;
  final bool canManage;
  final bool superadmin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final pending = canManage
        ? ref.watch(schoolMembersProvider(school.id, status: MemberStatus.pending)).value?.length
        : null;

    return ListView(
      padding: const EdgeInsets.all(Gaps.xl),
      children: [
        ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SchoolHeader(school: school),
              const SizedBox(height: Gaps.xl),
              if (canManage) ...[
                const SectionHeader(title: 'Kelola sekolah'),
                const SizedBox(height: Gaps.md),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      _NavTile(
                        icon: Icons.how_to_reg_rounded,
                        tone: palette.warning,
                        title: 'Persetujuan siswa',
                        subtitle: switch (pending) {
                          null => 'Tinjau permintaan bergabung',
                          0 => 'Tidak ada permintaan baru',
                          final count => '$count siswa menunggu persetujuan',
                        },
                        badge: pending == null || pending == 0 ? null : '$pending',
                        route: '$basePath/persetujuan',
                      ),
                      const Divider(height: 1),
                      _NavTile(
                        icon: Icons.groups_rounded,
                        tone: palette.info,
                        title: 'Anggota & peran',
                        subtitle: 'Guru, staf, dan siswa aktif',
                        route: '$basePath/anggota',
                      ),
                      const Divider(height: 1),
                      _NavTile(
                        icon: Icons.person_add_alt_1_rounded,
                        tone: palette.curhat,
                        title: superadmin ? 'Undang admin & staf' : 'Undang staf',
                        subtitle: 'Admin, pimpinan, konselor, dan petugas unit',
                        route: '$basePath/undang${superadmin ? '?peran=admin' : ''}',
                      ),
                      const Divider(height: 1),
                      _NavTile(
                        icon: Icons.upload_file_rounded,
                        tone: palette.edukasi,
                        title: 'Impor akun NISN',
                        subtitle: 'Buat akun siswa dari berkas CSV',
                        route: '$basePath/impor',
                      ),
                      const Divider(height: 1),
                      _NavTile(
                        icon: Icons.tune_rounded,
                        tone: palette.neutral,
                        title: 'Pengaturan sekolah',
                        subtitle: 'Profil, kode, layanan, dan target waktu',
                        route: '$basePath/pengaturan',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gaps.xl),
              ] else ...[
                const InfoBanner(
                  icon: Icons.info_outline_rounded,
                  message: 'Pengelolaan anggota dan pengaturan sekolah dilakukan oleh admin sekolah.',
                ),
                const SizedBox(height: Gaps.xl),
              ],
              const SectionHeader(title: 'Unit penanganan laporan'),
              const SizedBox(height: Gaps.md),
              _UnitsCard(schoolId: school.id),
            ],
          ),
        ),
      ],
    );
  }
}

class _SchoolHeader extends StatelessWidget {
  const _SchoolHeader({required this.school});

  final School school;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Gaps.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: context.colors.primaryContainer, borderRadius: BorderRadius.circular(Radii.md)),
                  child: Padding(
                    padding: const EdgeInsets.all(Gaps.md),
                    child: Icon(Icons.apartment_rounded, color: context.colors.onPrimaryContainer),
                  ),
                ),
                const SizedBox(width: Gaps.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(school.name, style: context.textStyles.titleMedium),
                      Text(
                        [school.level, if (school.city.isNotEmpty) '${school.city}, ${school.province}'].join(' · '),
                        style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (!school.active) StatusPill(label: 'Nonaktif', tone: context.palette.danger),
              ],
            ),
            const SizedBox(height: Gaps.lg),
            OutlinedButton.icon(
              onPressed: () => showSchoolCodeSheet(context, school),
              icon: const Icon(Icons.qr_code_2_rounded),
              label: Text('Kode sekolah: ${school.code}'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.route,
    this.badge,
  });

  final IconData icon;
  final ToneColors tone;
  final String title;
  final String subtitle;
  final String route;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.xs),
      leading: DecoratedBox(
        decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(Radii.md)),
        child: Padding(padding: const EdgeInsets.all(Gaps.sm), child: Icon(icon, color: tone.main)),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null) Badge(label: Text(badge!), backgroundColor: context.palette.warning.main),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
      onTap: () => context.push(route),
    );
  }
}

class _UnitsCard extends ConsumerWidget {
  const _UnitsCard({required this.schoolId});

  final String schoolId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final units = ref.watch(schoolUnitsProvider(schoolId));
    return Card(
      clipBehavior: Clip.antiAlias,
      child: units.when(
        loading: () => const Padding(padding: EdgeInsets.all(Gaps.lg), child: LinearProgressIndicator()),
        error: (error, _) => const ListTile(title: Text('Unit tidak dapat dimuat.')),
        data: (units) => Column(
          children: [
            for (final (index, unit) in units.indexed) ...[
              if (index > 0) const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.account_tree_outlined),
                title: Text(unit.name),
                subtitle: Text(
                  unit.categories.isEmpty
                      ? unit.description
                      : unit.categories.map((key) => kCategoryLabels[key] ?? key).join(', '),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
