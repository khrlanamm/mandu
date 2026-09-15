import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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

/// Detail permintaan Butuh Bantuan untuk konselor.
class StaffHelpScreen extends ConsumerWidget {
  const StaffHelpScreen({super.key, required this.requestId});

  final String requestId;

  Future<void> _openWhatsapp(BuildContext context, String number) async {
    var digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('0')) digits = '62${digits.substring(1)}';
    final opened = await launchUrl(Uri.parse('https://wa.me/$digits'), mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) showSnack(context, 'WhatsApp tidak dapat dibuka.', error: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currentAccountProvider);
    final schoolId = account?.schoolId;
    if (schoolId == null) return const Scaffold(body: LoadingView());
    final requestAsync = ref.watch(helpRequestProvider(schoolId, requestId));
    final request = requestAsync.value;
    final mine = request?.counselorUid == account?.uid;
    final palette = context.palette;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(Routes.staffCare),
              ),
        title: Text(request?.number ?? 'Permintaan bantuan'),
      ),
      bottomNavigationBar: request == null || !request.status.isOpen
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(Gaps.md),
                child: request.status == HelpStatus.menunggu
                    ? FilledButton.icon(
                        onPressed: () async {
                          final conversationId = await runGuarded(
                            context,
                            () => ref.read(careRepositoryProvider).claimHelp(schoolId: schoolId, requestId: requestId),
                            successMessage: 'Permintaan diambil.',
                          );
                          if (conversationId != null && context.mounted) {
                            context.push(Routes.staffConversation(conversationId));
                          }
                        },
                        icon: const Icon(Icons.pan_tool_alt_outlined),
                        label: const Text('Ambil permintaan ini'),
                      )
                    : mine
                        ? Row(
                            children: [
                              if (request.conversationId != null) ...[
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => context.push(Routes.staffConversation(request.conversationId!)),
                                    icon: const Icon(Icons.forum_outlined),
                                    label: const Text('Percakapan'),
                                  ),
                                ),
                                const SizedBox(width: Gaps.sm),
                              ],
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () => showActionSheet(context, (_) => _CloseHelpSheet(request: request)),
                                  icon: const Icon(Icons.done_all_rounded),
                                  label: const Text('Tutup'),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Ditangani ${request.counselorName}.',
                            textAlign: TextAlign.center,
                            style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                          ),
              ),
            ),
      body: AsyncValueView(
        value: requestAsync,
        onRetry: () => ref.invalidate(helpRequestProvider(schoolId, requestId)),
        data: (request) {
          if (request == null) {
            return const EmptyState(icon: Icons.search_off_rounded, title: 'Permintaan tidak ditemukan');
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxl),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (request.urgency == HelpUrgency.darurat) ...[
                      InfoBanner(
                        icon: Icons.priority_high_rounded,
                        title: 'Permintaan darurat',
                        message: 'Siswa menyatakan butuh bantuan sekarang juga. Segera hubungi dan pastikan keselamatannya.',
                        tone: palette.danger,
                      ),
                      const SizedBox(height: Gaps.md),
                    ],
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(request.student.name, style: context.textStyles.titleLarge),
                                ),
                                StatusPill(
                                  label: request.status.label,
                                  tone: request.status.tone(palette),
                                  icon: request.status.icon,
                                ),
                              ],
                            ),
                            Text(
                              'Kelas ${request.student.kelas ?? '-'}',
                              style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                            ),
                            const SizedBox(height: Gaps.md),
                            DetailRow(icon: Icons.checklist_rounded, label: 'Kebutuhan', value: request.needLabels.join(', ')),
                            DetailRow(icon: Icons.bolt_rounded, label: 'Urgensi', value: request.urgency.label),
                            DetailRow(
                              icon: request.contactMethod.icon,
                              label: 'Cara dihubungi',
                              value: '${request.contactMethod.label} · ${request.contactTime.label}',
                            ),
                            if (request.note != null)
                              DetailRow(icon: Icons.notes_rounded, label: 'Catatan siswa', value: request.note!),
                            if (request.createdAt != null)
                              DetailRow(icon: Icons.send_outlined, label: 'Masuk', value: formatDateTime(request.createdAt!)),
                            if (request.whatsapp != null) ...[
                              const SizedBox(height: Gaps.md),
                              OutlinedButton.icon(
                                onPressed: () => _openWhatsapp(context, request.whatsapp!),
                                icon: const Icon(Icons.chat_outlined),
                                label: Text('WhatsApp ${request.whatsapp}'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (request.closingNote != null) ...[
                      const SizedBox(height: Gaps.md),
                      InfoBanner(
                        icon: Icons.check_circle_outline_rounded,
                        title: 'Pesan penutup',
                        message: request.closingNote!,
                        tone: palette.success,
                      ),
                    ],
                    const SizedBox(height: Gaps.lg),
                    Text(
                      'Permintaan ini hanya terlihat oleh siswa yang mengirim dan konselor sekolah.',
                      style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
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

class _CloseHelpSheet extends ConsumerStatefulWidget {
  const _CloseHelpSheet({required this.request});

  final HelpRequest request;

  @override
  ConsumerState<_CloseHelpSheet> createState() => _CloseHelpSheetState();
}

class _CloseHelpSheetState extends ConsumerState<_CloseHelpSheet> with ActionSheetState {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: 'Tutup permintaan',
      description: 'Pesan penutup akan dibaca siswa. Tuliskan hasil pendampingan atau langkah selanjutnya.',
      submitLabel: 'Tutup permintaan',
      busy: busy,
      error: error,
      onSubmit: () {
        if (_note.text.trim().length < 5) return fail('Tuliskan pesan penutup minimal 5 karakter.');
        submit(
          () => ref.read(careRepositoryProvider).closeHelp(
                schoolId: widget.request.schoolId,
                requestId: widget.request.id,
                note: _note.text,
              ),
          successMessage: 'Permintaan ditutup.',
        );
      },
      children: [
        TextField(
          controller: _note,
          enabled: !busy,
          minLines: 3,
          maxLines: 8,
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(labelText: 'Pesan penutup untuk siswa', alignLabelWithHint: true),
        ),
      ],
    );
  }
}
