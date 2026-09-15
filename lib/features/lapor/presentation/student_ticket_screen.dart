import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/catalog.dart';
import '../../../core/files/pending_attachment.dart';
import '../../auth/application/session_controller.dart';
import '../data/ticket_repository.dart';
import '../domain/ticket.dart';
import 'widgets/ticket_widgets.dart';

class StudentTicketScreen extends ConsumerWidget {
  const StudentTicketScreen({super.key, required this.ticketId, this.justSubmitted = false});

  final String ticketId;
  final bool justSubmitted;

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
                onPressed: () => context.go(Routes.studentActivity),
              ),
        title: const Text('Laporan saya'),
      ),
      body: schoolId == null
          ? const LoadingView()
          : AsyncValueView(
              value: ref.watch(ticketProvider(schoolId, ticketId)),
              onRetry: () => ref.invalidate(ticketProvider(schoolId, ticketId)),
              data: (ticket) => ticket == null
                  ? const EmptyState(icon: Icons.search_off_rounded, title: 'Laporan tidak ditemukan')
                  : _StudentTicketBody(ticket: ticket, justSubmitted: justSubmitted),
            ),
    );
  }
}

class _StudentTicketBody extends ConsumerWidget {
  const _StudentTicketBody({required this.ticket, required this.justSubmitted});

  final Ticket ticket;
  final bool justSubmitted;

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Batalkan laporan?',
      message: 'Laporan ${ticket.number} tidak akan diproses. Tindakan ini tidak dapat diurungkan.',
      confirmLabel: 'Batalkan laporan',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    await runGuarded(
      context,
      () => ref.read(ticketRepositoryProvider).cancel(schoolId: ticket.schoolId, ticketId: ticket.id),
      successMessage: 'Laporan dibatalkan.',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    final timeline = ref.watch(ticketTimelineProvider(ticket.schoolId, ticket.id, publicOnly: true));
    final incident = formatIncident(ticket.incidentDate, ticket.incidentTime);
    final showSteps = ticket.status != TicketStatus.ditolak && ticket.status != TicketStatus.dibatalkan;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxl),
      children: [
        ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (justSubmitted) ...[
                InfoBanner(
                  icon: Icons.mark_email_read_outlined,
                  title: 'Laporan terkirim',
                  message: 'Simpan nomor ${ticket.number}. Kamu akan mendapat notifikasi setiap ada perkembangan.',
                  tone: palette.success,
                ),
                const SizedBox(height: Gaps.lg),
              ],
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(ticket.number, style: context.textStyles.labelMedium)),
                          TicketStatusPill(status: ticket.status),
                        ],
                      ),
                      const SizedBox(height: Gaps.sm),
                      Text(ticket.title, style: context.textStyles.titleLarge),
                      Text('${ticket.categoryLabel} · ${ticket.subcategoryLabel}', style: muted),
                      const SizedBox(height: Gaps.md),
                      Text(ticket.status.description, style: context.textStyles.bodyMedium),
                      if (ticket.unitName != null) ...[
                        const SizedBox(height: Gaps.xs),
                        Text('Ditangani oleh ${ticket.unitName}', style: muted),
                      ],
                      if (showSteps) ...[
                        const SizedBox(height: Gaps.lg),
                        TicketProgressSteps(status: ticket.status),
                      ],
                    ],
                  ),
                ),
              ),
              if (ticket.status == TicketStatus.perluDilengkapi) ...[
                const SizedBox(height: Gaps.lg),
                InfoBanner(
                  icon: Icons.edit_note_rounded,
                  title: 'Sekolah meminta informasi tambahan',
                  message: ticket.infoRequest?.message ?? 'Lengkapi laporanmu agar bisa diverifikasi.',
                  tone: palette.warning,
                ),
                const SizedBox(height: Gaps.sm),
                FilledButton.icon(
                  onPressed: () => showActionSheet(context, (_) => _SupplyInfoSheet(ticket: ticket)),
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Lengkapi laporan'),
                ),
              ],
              if (ticket.status == TicketStatus.ditolak) ...[
                const SizedBox(height: Gaps.lg),
                InfoBanner(
                  icon: Icons.block_rounded,
                  title: 'Laporan tidak dilanjutkan',
                  message: [ticket.rejection?.reason.label ?? 'Alasan tidak disebutkan', ?ticket.rejection?.note].join('. '),
                  tone: palette.danger,
                ),
              ],
              if (ticket.resolution != null) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Hasil tindak lanjut'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Gaps.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticket.resolution!.note, style: context.textStyles.bodyMedium),
                        const SizedBox(height: Gaps.sm),
                        AttachmentGallery(attachments: ticket.resolution!.attachments),
                        const SizedBox(height: Gaps.sm),
                        Text(
                          [
                            ticket.resolution!.resolvedByName,
                            if (ticket.resolution!.resolvedAt != null) formatDateTime(ticket.resolution!.resolvedAt!),
                          ].join(' · '),
                          style: muted,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Gaps.md),
                _RatingCard(ticket: ticket),
              ],
              const SizedBox(height: Gaps.xl),
              const SectionHeader(title: 'Isi laporan'),
              const SizedBox(height: Gaps.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(ticket.description, style: context.textStyles.bodyMedium),
                      const SizedBox(height: Gaps.md),
                      DetailRow(icon: Icons.place_outlined, label: 'Lokasi', value: ticket.location),
                      if (incident != null) DetailRow(icon: Icons.event_outlined, label: 'Waktu kejadian', value: incident),
                      if (ticket.createdAt != null)
                        DetailRow(icon: Icons.send_outlined, label: 'Dikirim', value: formatDateTime(ticket.createdAt!)),
                      DetailRow(
                        icon: ticket.anonymous ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        label: 'Identitas',
                        value: ticket.anonymous ? 'Dirahasiakan dari guru dan staf' : 'Terlihat oleh petugas yang menangani',
                      ),
                      if (ticket.attachments.isNotEmpty) ...[
                        const SizedBox(height: Gaps.md),
                        AttachmentGallery(attachments: ticket.attachments),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Gaps.xl),
              const SectionHeader(title: 'Riwayat'),
              const SizedBox(height: Gaps.md),
              AsyncValueView(
                value: timeline,
                loading: const Padding(padding: EdgeInsets.all(Gaps.xl), child: LoadingView()),
                data: (events) => TicketTimeline(events: events),
              ),
              if (ticket.status.cancellable) ...[
                const SizedBox(height: Gaps.xl),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(foregroundColor: palette.danger.main),
                  onPressed: () => _cancel(context, ref),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Batalkan laporan'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RatingCard extends ConsumerStatefulWidget {
  const _RatingCard({required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<_RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends ConsumerState<_RatingCard> {
  final _comment = TextEditingController();
  int _score = 0;
  bool _busy = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _busy = true);
    await runGuarded(
      context,
      () => ref.read(ticketRepositoryProvider).rate(
            schoolId: widget.ticket.schoolId,
            ticketId: widget.ticket.id,
            score: _score,
            comment: _comment.text,
          ),
      successMessage: 'Terima kasih atas penilaianmu.',
    );
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final rating = widget.ticket.rating;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Gaps.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(rating == null ? 'Bagaimana penanganan laporan ini?' : 'Penilaianmu', style: context.textStyles.titleSmall),
            const SizedBox(height: Gaps.sm),
            if (rating != null) ...[
              RatingStars(value: rating.score, size: 28),
              if (rating.comment != null) ...[
                const SizedBox(height: Gaps.xs),
                Text('"${rating.comment}"', style: context.textStyles.bodyMedium),
              ],
            ] else ...[
              Center(child: RatingStars(value: _score, onChanged: _busy ? null : (score) => setState(() => _score = score))),
              if (_score > 0) ...[
                const SizedBox(height: Gaps.sm),
                TextField(
                  controller: _comment,
                  enabled: !_busy,
                  maxLength: 500,
                  decoration: const InputDecoration(labelText: 'Komentar (opsional)'),
                ),
                FilledButton(
                  onPressed: _busy ? null : _submit,
                  child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Kirim penilaian'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _SupplyInfoSheet extends ConsumerStatefulWidget {
  const _SupplyInfoSheet({required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<_SupplyInfoSheet> createState() => _SupplyInfoSheetState();
}

class _SupplyInfoSheetState extends ConsumerState<_SupplyInfoSheet> with ActionSheetState {
  final _message = TextEditingController();
  final _uploaded = <PendingAttachment, TicketAttachment>{};
  List<PendingAttachment> _files = [];

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  void _send() {
    if (_message.text.trim().length < 5) return fail('Tuliskan informasi tambahan minimal 5 karakter.');
    final repository = ref.read(ticketRepositoryProvider);
    final ticket = widget.ticket;
    submit(() async {
      final attachments = await uploadPending(
        repository: repository,
        schoolId: ticket.schoolId,
        ticketId: ticket.id,
        folder: AttachmentFolder.lampiran,
        files: _files,
        uploaded: _uploaded,
      );
      await repository.supplyInfo(schoolId: ticket.schoolId, ticketId: ticket.id, message: _message.text, attachments: attachments);
    }, successMessage: 'Laporan dilengkapi dan dikirim ulang untuk verifikasi.');
  }

  @override
  Widget build(BuildContext context) {
    final remaining = (10 - widget.ticket.attachments.length).clamp(0, kMaxAttachments);
    return ActionSheet(
      title: 'Lengkapi laporan',
      description: widget.ticket.infoRequest?.message,
      submitLabel: 'Kirim tambahan',
      busy: busy,
      error: error,
      onSubmit: _send,
      children: [
        TextField(
          controller: _message,
          enabled: !busy,
          minLines: 3,
          maxLines: 8,
          maxLength: 2000,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(labelText: 'Informasi tambahan', alignLabelWithHint: true),
        ),
        if (remaining > 0)
          AttachmentPickerField(
            files: _files,
            max: remaining,
            enabled: !busy,
            onChanged: (files) => setState(() => _files = files),
          ),
      ],
    );
  }
}
