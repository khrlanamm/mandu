import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/mandu_logo.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/roles.dart';
import '../../auth/application/session_controller.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';

class StaffHomeScreen extends ConsumerWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currentAccountProvider);
    final role = account?.role;
    if (account == null || account.schoolId == null || role == null) return const Scaffold(body: LoadingView());

    final isAdmin = role == SchoolRole.admin;
    final pendingCount = isAdmin
        ? ref.watch(schoolMembersProvider(account.schoolId!, status: MemberStatus.pending)).value?.length
        : null;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.xl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(alignment: Alignment.centerLeft, child: ManduLogo(size: 30)),
                  const SizedBox(height: Gaps.xl),
                  Text('Halo, ${account.firstName}', style: context.textStyles.headlineMedium),
                  const SizedBox(height: Gaps.sm),
                  Wrap(
                    spacing: Gaps.sm,
                    runSpacing: Gaps.sm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      StatusPill(label: role.label, tone: context.palette.info, icon: Icons.verified_user_outlined),
                      Text(
                        account.schoolName ?? '',
                        style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gaps.xl),
                  if (isAdmin) ...[
                    const SectionHeader(title: 'Perlu tindakan'),
                    const SizedBox(height: Gaps.md),
                    _ActionTile(
                      icon: Icons.how_to_reg_rounded,
                      tone: context.palette.warning,
                      title: 'Persetujuan siswa',
                      subtitle: pendingCount == null
                          ? 'Memuat...'
                          : pendingCount == 0
                              ? 'Tidak ada permintaan baru'
                              : '$pendingCount siswa menunggu persetujuan',
                      onTap: () => context.go('${Routes.staffSchool}/persetujuan'),
                    ),
                    const SizedBox(height: Gaps.md),
                    _ActionTile(
                      icon: Icons.groups_rounded,
                      tone: context.palette.info,
                      title: 'Anggota & peran',
                      subtitle: 'Atur peran guru, staf, dan siswa',
                      onTap: () => context.go('${Routes.staffSchool}/anggota'),
                    ),
                    const SizedBox(height: Gaps.md),
                    _ActionTile(
                      icon: Icons.upload_file_rounded,
                      tone: context.palette.edukasi,
                      title: 'Impor akun NISN',
                      subtitle: 'Buat akun siswa dari berkas CSV',
                      onTap: () => context.go('${Routes.staffSchool}/impor'),
                    ),
                  ] else
                    InfoBanner(
                      icon: Icons.construction_rounded,
                      title: 'Ruang kerja ${role.label}',
                      message: switch (role) {
                        SchoolRole.konselor => 'Curhat, permintaan bantuan, dan laporan keamanan yang kamu tangani akan tampil di sini.',
                        SchoolRole.petugas => 'Laporan yang diteruskan ke unitmu akan tampil di tab Tugas.',
                        SchoolRole.pimpinan => 'Ringkasan laporan, aspirasi, dan kinerja layanan sekolah akan tampil di sini.',
                        _ => 'Fitur untuk peranmu sedang disiapkan.',
                      },
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

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.tone, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final ToneColors tone;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.sm),
        leading: DecoratedBox(
          decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(Radii.md)),
          child: Padding(padding: const EdgeInsets.all(Gaps.sm), child: Icon(icon, color: tone.main)),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
