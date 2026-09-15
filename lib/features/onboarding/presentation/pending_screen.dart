import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/roles.dart';
import '../../auth/application/session_controller.dart';
import '../../members/data/membership_repository.dart';

class PendingScreen extends ConsumerStatefulWidget {
  const PendingScreen({super.key});

  @override
  ConsumerState<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends ConsumerState<PendingScreen> {
  bool _busy = false;

  Future<void> _cancel() async {
    final confirmed = await confirmAction(
      context,
      title: 'Batalkan permintaan?',
      message: 'Kamu bisa bergabung lagi dengan kode sekolah yang benar.',
      confirmLabel: 'Batalkan permintaan',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    await runGuarded(context, () => ref.read(membershipRepositoryProvider).cancelJoin());
    await ref.read(sessionControllerProvider.notifier).refresh();
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _checkAgain() async {
    setState(() => _busy = true);
    await ref.read(sessionControllerProvider.notifier).refresh();
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(currentAccountProvider);
    if (account == null || account.schoolId == null) return const Scaffold(body: LoadingView());

    final rejected = account.status == AccountStatus.rejected;
    final membership = rejected ? ref.watch(ownMembershipProvider(account.schoolId!, account.uid)).value : null;
    final tone = rejected ? context.palette.danger : context.palette.warning;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(tooltip: 'Akun', onPressed: () => context.push(Routes.account), icon: const Icon(Icons.person_outline_rounded)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Gaps.xl),
            child: ContentWidth(
              maxWidth: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: tone.container, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.xl),
                        child: Icon(rejected ? Icons.block_rounded : Icons.hourglass_top_rounded, size: 44, color: tone.main),
                      ),
                    ),
                  ),
                  const SizedBox(height: Gaps.xl),
                  Text(
                    rejected ? 'Permintaan belum disetujui' : 'Menunggu persetujuan',
                    textAlign: TextAlign.center,
                    style: context.textStyles.headlineSmall,
                  ),
                  const SizedBox(height: Gaps.sm),
                  Text(
                    rejected
                        ? 'Admin ${account.schoolName} belum dapat menyetujui permintaanmu.'
                        : 'Admin ${account.schoolName} akan memeriksa datamu. Akses terbuka otomatis setelah disetujui.',
                    textAlign: TextAlign.center,
                    style: context.textStyles.bodyLarge?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  if (rejected && membership?.rejectionReason != null) ...[
                    const SizedBox(height: Gaps.lg),
                    InfoBanner(
                      icon: Icons.info_outline_rounded,
                      title: 'Alasan',
                      message: membership!.rejectionReason!,
                      tone: context.palette.danger,
                    ),
                  ],
                  const SizedBox(height: Gaps.xl),
                  if (rejected)
                    FilledButton(
                      onPressed: _busy ? null : () => context.go(Routes.join),
                      child: const Text('Ajukan ulang'),
                    )
                  else ...[
                    FilledButton.tonal(
                      onPressed: _busy ? null : _checkAgain,
                      child: _busy ? const ButtonSpinner() : const Text('Periksa status'),
                    ),
                    const SizedBox(height: Gaps.sm),
                    TextButton(onPressed: _busy ? null : _cancel, child: const Text('Batalkan permintaan')),
                  ],
                  const SizedBox(height: Gaps.sm),
                  TextButton(
                    onPressed: _busy ? null : () => ref.read(sessionControllerProvider.notifier).signOut(),
                    child: const Text('Keluar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
