import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../../lapor/presentation/widgets/ticket_widgets.dart';
import '../data/care_repository.dart';
import '../domain/care.dart';
import 'widgets/care_widgets.dart';

class StudentHelpScreen extends ConsumerWidget {
  const StudentHelpScreen({super.key, required this.requestId});

  final String requestId;

  Future<void> _cancel(BuildContext context, WidgetRef ref, HelpRequest request) async {
    final confirmed = await confirmAction(
      context,
      title: 'Batalkan permintaan?',
      message: 'Guru BK tidak akan menerima permintaan ini. Kamu bisa meminta bantuan lagi kapan saja.',
      confirmLabel: 'Batalkan',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    await runGuarded(
      context,
      () => ref.read(careRepositoryProvider).cancelHelp(schoolId: request.schoolId, requestId: request.id),
      successMessage: 'Permintaan dibatalkan.',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(Routes.studentHelp),
              ),
        title: const Text('Permintaan bantuan'),
      ),
      body: schoolId == null
          ? const LoadingView()
          : AsyncValueView(
              value: ref.watch(helpRequestProvider(schoolId, requestId)),
              onRetry: () => ref.invalidate(helpRequestProvider(schoolId, requestId)),
              data: (request) {
                if (request == null) {
                  return const EmptyState(icon: Icons.search_off_rounded, title: 'Permintaan tidak ditemukan');
                }
                final palette = context.palette;
                final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
                return ListView(
                  padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxl),
                  children: [
                    ContentWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(Gaps.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(request.number, style: context.textStyles.labelMedium)),
                                      StatusPill(
                                        label: request.status.label,
                                        tone: request.status.tone(palette),
                                        icon: request.status.icon,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Gaps.md),
                                  Text(
                                    switch (request.status) {
                                      HelpStatus.menunggu => 'Permintaanmu sudah masuk ke guru BK. Mereka akan segera menghubungi.',
                                      HelpStatus.ditangani => '${request.counselorName} sedang membantumu.',
                                      HelpStatus.selesai => 'Permintaan sudah ditutup guru BK.',
                                      HelpStatus.dibatalkan => 'Permintaan ini kamu batalkan.',
                                    },
                                    style: context.textStyles.bodyMedium,
                                  ),
                                  const SizedBox(height: Gaps.md),
                                  DetailRow(
                                    icon: Icons.checklist_rounded,
                                    label: 'Kebutuhan',
                                    value: request.needLabels.join(', '),
                                  ),
                                  DetailRow(icon: Icons.bolt_rounded, label: 'Urgensi', value: request.urgency.label),
                                  DetailRow(
                                    icon: request.contactMethod.icon,
                                    label: 'Cara dihubungi',
                                    value: '${request.contactMethod.label} · ${request.contactTime.label}',
                                  ),
                                  if (request.note != null)
                                    DetailRow(icon: Icons.notes_rounded, label: 'Catatan', value: request.note!),
                                  if (request.createdAt != null)
                                    DetailRow(
                                      icon: Icons.send_outlined,
                                      label: 'Dikirim',
                                      value: formatDateTime(request.createdAt!),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (request.conversationId != null) ...[
                            const SizedBox(height: Gaps.lg),
                            FilledButton.icon(
                              onPressed: () => context.push(Routes.studentConversation(request.conversationId!)),
                              icon: const Icon(Icons.forum_rounded),
                              label: const Text('Buka percakapan dengan konselor'),
                            ),
                          ],
                          if (request.closingNote != null) ...[
                            const SizedBox(height: Gaps.lg),
                            InfoBanner(
                              icon: Icons.check_circle_outline_rounded,
                              title: 'Pesan penutup dari ${request.counselorName ?? "guru BK"}',
                              message: request.closingNote!,
                              tone: palette.success,
                            ),
                          ],
                          const SizedBox(height: Gaps.lg),
                          const EmergencyContactsCard(),
                          if (request.status == HelpStatus.menunggu) ...[
                            const SizedBox(height: Gaps.lg),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(foregroundColor: palette.danger.main),
                              onPressed: () => _cancel(context, ref, request),
                              icon: const Icon(Icons.cancel_outlined),
                              label: const Text('Batalkan permintaan'),
                            ),
                          ],
                          const SizedBox(height: Gaps.md),
                          Text('Hanya kamu dan guru BK yang dapat melihat permintaan ini.', style: muted),
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
