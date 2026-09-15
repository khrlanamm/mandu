import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../data/care_repository.dart';
import 'widgets/care_widgets.dart';

/// Butuh Bantuan untuk siswa: permintaan yang sedang berjalan, tombol minta bantuan, dan riwayat.
class HelpHubScreen extends ConsumerWidget {
  const HelpHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(myHelpRequestsProvider);
    final tone = context.palette.bantuan;

    return Scaffold(
      appBar: AppBar(title: const Text('Butuh Bantuan')),
      body: AsyncValueView(
        value: requests,
        onRetry: () => ref.invalidate(myHelpRequestsProvider),
        data: (all) {
          final open = all.where((request) => request.status.isOpen).toList();
          final history = all.where((request) => !request.status.isOpen).toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: tone.container,
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.volunteer_activism_rounded, color: tone.main, size: 28),
                            const SizedBox(height: Gaps.sm),
                            Text(
                              'Tidak perlu menjelaskan panjang lebar',
                              style: context.textStyles.titleMedium?.copyWith(color: tone.onContainer),
                            ),
                            const SizedBox(height: Gaps.xs),
                            Text(
                              'Pilih apa yang kamu butuhkan dan kapan bisa dihubungi. Guru BK akan menghubungimu.',
                              style: context.textStyles.bodyMedium?.copyWith(color: tone.onContainer),
                            ),
                            const SizedBox(height: Gaps.lg),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(backgroundColor: tone.main, foregroundColor: tone.onMain),
                              onPressed: () => context.push(Routes.studentHelpForm),
                              icon: const Icon(Icons.support_agent_rounded),
                              label: const Text('Minta bantuan'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Gaps.lg),
                    const EmergencyContactsCard(),
                    if (open.isNotEmpty) ...[
                      const SizedBox(height: Gaps.xl),
                      const SectionHeader(title: 'Sedang berjalan'),
                      const SizedBox(height: Gaps.md),
                      for (final request in open) ...[
                        HelpRequestCard(
                          request: request,
                          onTap: () => context.push(Routes.studentHelpDetail(request.id)),
                        ),
                        const SizedBox(height: Gaps.md),
                      ],
                    ],
                    if (history.isNotEmpty) ...[
                      const SizedBox(height: Gaps.xl),
                      const SectionHeader(title: 'Riwayat'),
                      const SizedBox(height: Gaps.md),
                      for (final request in history) ...[
                        HelpRequestCard(
                          request: request,
                          onTap: () => context.push(Routes.studentHelpDetail(request.id)),
                        ),
                        const SizedBox(height: Gaps.md),
                      ],
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
