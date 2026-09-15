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
import '../../lapor/data/ticket_repository.dart';
import '../../lapor/domain/ticket.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';
import '../../notifications/presentation/notification_bell.dart';

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
    final access = ref.watch(staffTicketAccessProvider);
    final tickets = ref.watch(staffTicketsProvider).value;
    final palette = context.palette;

    int count(bool Function(Ticket ticket) test) => tickets?.where(test).length ?? 0;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.xl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      ManduLogo(size: 30),
                      Spacer(),
                      NotificationBell(route: Routes.staffNotifications),
                    ],
                  ),
                  const SizedBox(height: Gaps.xl),
                  Text('Halo, ${account.firstName}', style: context.textStyles.headlineMedium),
                  const SizedBox(height: Gaps.sm),
                  Wrap(
                    spacing: Gaps.sm,
                    runSpacing: Gaps.sm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      StatusPill(label: role.label, tone: palette.info, icon: Icons.verified_user_outlined),
                      if (access?.canVerify ?? false)
                        StatusPill(label: 'Tim Verifikasi', tone: palette.success, icon: Icons.fact_check_outlined),
                      Text(
                        account.schoolName ?? '',
                        style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gaps.xl),
                  SectionHeader(
                    title: 'Laporan',
                    action: TextButton(onPressed: () => context.go(Routes.staffTasks), child: const Text('Buka tugas')),
                  ),
                  const SizedBox(height: Gaps.md),
                  if (access != null && !access.seesAll && access.units.isEmpty)
                    const InfoBanner(
                      icon: Icons.info_outline_rounded,
                      message: 'Kamu belum ditugaskan ke unit mana pun. Minta admin sekolah mengatur unitmu agar laporan tampil di sini.',
                    )
                  else
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: Gaps.md,
                      crossAxisSpacing: Gaps.md,
                      childAspectRatio: 0.95,
                      children: [
                        if (access?.seesAll ?? false)
                          _StatTile(
                            label: 'Perlu verifikasi',
                            value: tickets == null ? null : count((ticket) => ticket.status == TicketStatus.menungguVerifikasi),
                            icon: Icons.fact_check_outlined,
                            tone: palette.info,
                          )
                        else
                          _StatTile(
                            label: 'Baru diteruskan',
                            value: tickets == null ? null : count((ticket) => ticket.status == TicketStatus.diteruskan),
                            icon: Icons.forward_rounded,
                            tone: palette.info,
                          ),
                        _StatTile(
                          label: 'Sedang ditangani',
                          value: tickets == null ? null : count((ticket) => ticket.status.inHandling),
                          icon: Icons.construction_rounded,
                          tone: palette.curhat,
                        ),
                        _StatTile(
                          label: 'Lewat batas waktu',
                          value: tickets == null ? null : count((ticket) => !ticket.status.isClosed && ticket.isOverdue()),
                          icon: Icons.timer_off_outlined,
                          tone: palette.danger,
                        ),
                      ],
                    ),
                  if (isAdmin) ...[
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Kelola sekolah'),
                    const SizedBox(height: Gaps.md),
                    _ActionTile(
                      icon: Icons.how_to_reg_rounded,
                      tone: palette.warning,
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
                      tone: palette.info,
                      title: 'Anggota & peran',
                      subtitle: 'Atur peran guru, staf, dan siswa',
                      onTap: () => context.go('${Routes.staffSchool}/anggota'),
                    ),
                    const SizedBox(height: Gaps.md),
                    _ActionTile(
                      icon: Icons.upload_file_rounded,
                      tone: palette.edukasi,
                      title: 'Impor akun NISN',
                      subtitle: 'Buat akun siswa dari berkas CSV',
                      onTap: () => context.go('${Routes.staffSchool}/impor'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.icon, required this.tone});

  final String label;
  final int? value;
  final IconData icon;
  final ToneColors tone;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tone.container,
      borderRadius: BorderRadius.circular(Radii.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(Routes.staffTasks),
        child: Padding(
          padding: const EdgeInsets.all(Gaps.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: tone.main, size: 22),
              const Spacer(),
              Text(
                value?.toString() ?? '–',
                style: context.textStyles.headlineMedium?.copyWith(
                  color: tone.onContainer,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.labelMedium?.copyWith(color: tone.onContainer),
              ),
            ],
          ),
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
