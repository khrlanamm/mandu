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
import '../../../core/domain/catalog.dart';
import '../../auth/application/session_controller.dart';
import '../data/ticket_repository.dart';
import '../domain/staff_queue.dart';
import '../domain/ticket.dart';
import 'staff_ticket_sheets.dart';
import 'widgets/ticket_widgets.dart';

enum _MenuAction { internalNote, reassign }

class StaffTicketScreen extends ConsumerWidget {
  const StaffTicketScreen({super.key, required this.ticketId});

  final String ticketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    final access = ref.watch(staffTicketAccessProvider);
    if (schoolId == null || access == null) return const Scaffold(body: LoadingView());

    final ticketAsync = ref.watch(ticketProvider(schoolId, ticketId));
    final ticket = ticketAsync.value;
    final canNote = ticket != null &&
        ticket.status != TicketStatus.ditolak &&
        ticket.status != TicketStatus.dibatalkan &&
        (access.isVerifier || access.canHandle(ticket));
    final canReassign = ticket != null && access.isVerifier && ticket.status.inHandling;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(tooltip: 'Tutup', icon: const Icon(Icons.close_rounded), onPressed: () => context.go(Routes.staffTasks)),
        title: Text(ticket?.number ?? 'Detail laporan'),
        actions: [
          if (canNote || canReassign)
            PopupMenuButton<_MenuAction>(
              tooltip: 'Aksi lain',
              onSelected: (action) => switch (action) {
                _MenuAction.internalNote => showActionSheet(
                    context,
                    (_) => ProgressSheet(ticket: ticket, internalOnly: true, canAttach: access.canHandle(ticket)),
                  ),
                _MenuAction.reassign => showActionSheet(context, (_) => ReassignSheet(ticket: ticket)),
              },
              itemBuilder: (context) => [
                if (canNote)
                  const PopupMenuItem(
                    value: _MenuAction.internalNote,
                    child: ListTile(leading: Icon(Icons.lock_outline_rounded), title: Text('Catatan internal')),
                  ),
                if (canReassign)
                  const PopupMenuItem(
                    value: _MenuAction.reassign,
                    child: ListTile(leading: Icon(Icons.alt_route_rounded), title: Text('Alihkan unit')),
                  ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: ticket == null ? null : _ActionBar(ticket: ticket, access: access),
      body: AsyncValueView(
        value: ticketAsync,
        onRetry: () => ref.invalidate(ticketProvider(schoolId, ticketId)),
        data: (ticket) => ticket == null
            ? const EmptyState(icon: Icons.search_off_rounded, title: 'Laporan tidak ditemukan')
            : _StaffTicketBody(ticket: ticket),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.ticket, required this.access});

  final Ticket ticket;
  final StaffTicketAccess access;

  @override
  Widget build(BuildContext context) {
    Widget outlined(String label, WidgetBuilder sheet) =>
        OutlinedButton(onPressed: () => showActionSheet(context, sheet), child: Text(label, textAlign: TextAlign.center));
    Widget filled(String label, WidgetBuilder sheet) =>
        FilledButton(onPressed: () => showActionSheet(context, sheet), child: Text(label, textAlign: TextAlign.center));

    final status = ticket.status;
    final actions = <Widget>[
      if (!access.readOnly && access.isVerifier && status == TicketStatus.menungguVerifikasi) ...[
        outlined('Tolak', (_) => RejectSheet(ticket: ticket)),
        outlined('Minta data', (_) => RequestInfoSheet(ticket: ticket)),
        filled('Teruskan', (_) => ForwardSheet(ticket: ticket)),
      ] else if (!access.readOnly && access.isVerifier && status == TicketStatus.perluDilengkapi) ...[
        outlined('Tolak', (_) => RejectSheet(ticket: ticket)),
        filled('Teruskan', (_) => ForwardSheet(ticket: ticket)),
      ] else if (status.inHandling && access.canHandle(ticket)) ...[
        outlined('Tambah progres', (_) => ProgressSheet(ticket: ticket, internalOnly: false, canAttach: true)),
        filled('Selesaikan', (_) => ResolveSheet(ticket: ticket)),
      ],
    ];
    if (actions.isEmpty) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(Gaps.md),
          // heightFactor 1: bottomNavigationBar mendapat tinggi layar penuh sebagai batas.
          child: Align(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: kContentMaxWidth),
              child: Row(
                children: [
                  for (var index = 0; index < actions.length; index++) ...[
                    if (index > 0) const SizedBox(width: Gaps.sm),
                    Expanded(child: actions[index]),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StaffTicketBody extends ConsumerWidget {
  const _StaffTicketBody({required this.ticket});

  final Ticket ticket;

  Future<void> _openWhatsapp(BuildContext context, String number) async {
    var digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('0')) digits = '62${digits.substring(1)}';
    final opened = await launchUrl(Uri.parse('https://wa.me/$digits'), mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) showSnack(context, 'WhatsApp tidak dapat dibuka.', error: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    final timeline = ref.watch(ticketTimelineProvider(ticket.schoolId, ticket.id, publicOnly: false));
    final incident = formatIncident(ticket.incidentDate, ticket.incidentTime);
    final suggested = ticket.suggestedCategory == null ? null : reportCategory(ticket.suggestedCategory!);
    final details = ticket.details;

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
                      Wrap(
                        spacing: Gaps.sm,
                        runSpacing: Gaps.xs,
                        children: [
                          TicketStatusPill(status: ticket.status),
                          PriorityPill(priority: ticket.priority),
                          if (!ticket.status.isClosed) SlaPill(ticket: ticket),
                        ],
                      ),
                      const SizedBox(height: Gaps.md),
                      Text(ticket.title, style: context.textStyles.titleLarge),
                      Text('${ticket.categoryLabel} · ${ticket.subcategoryLabel}', style: muted),
                      const SizedBox(height: Gaps.sm),
                      if (ticket.createdAt != null)
                        Text('Masuk ${formatDateTime(ticket.createdAt!)} (${formatRelative(ticket.createdAt!)})', style: muted),
                      Text(ticket.unitName == null ? 'Belum diteruskan ke unit' : 'Unit: ${ticket.unitName}', style: muted),
                    ],
                  ),
                ),
              ),
              if (ticket.priority != TicketPriority.normal && ticket.priorityReason != null) ...[
                const SizedBox(height: Gaps.md),
                InfoBanner(
                  icon: Icons.priority_high_rounded,
                  title: 'Prioritas ${ticket.priority.label.toLowerCase()}',
                  message: ticket.priorityReason!,
                  tone: ticket.priority == TicketPriority.darurat ? palette.danger : palette.warning,
                ),
              ],
              if (ticket.possibleDuplicateOf != null && !ticket.status.isClosed) ...[
                const SizedBox(height: Gaps.md),
                InfoBanner(
                  icon: Icons.copy_all_rounded,
                  title: 'Kemungkinan laporan ganda',
                  message: 'Ada laporan dengan kategori dan lokasi yang sama dalam 7 hari terakhir.',
                  tone: palette.warning,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(Routes.staffTicket(ticket.possibleDuplicateOf!)),
                    child: const Text('Buka laporan serupa'),
                  ),
                ),
              ],
              if (suggested != null && ticket.status.awaitingVerification) ...[
                const SizedBox(height: Gaps.md),
                InfoBanner(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Saran kategori: ${suggested.label}',
                  message: 'Isi laporan tampak lebih cocok dengan kategori ini. Kamu bisa mengubahnya saat meneruskan.',
                ),
              ],
              if (ticket.status == TicketStatus.perluDilengkapi && ticket.infoRequest != null) ...[
                const SizedBox(height: Gaps.md),
                InfoBanner(
                  icon: Icons.hourglass_empty_rounded,
                  title: 'Menunggu pelapor melengkapi',
                  message: ticket.infoRequest!.message,
                  tone: palette.warning,
                ),
              ],
              if (ticket.rejection != null) ...[
                const SizedBox(height: Gaps.md),
                InfoBanner(
                  icon: Icons.block_rounded,
                  title: 'Ditolak: ${ticket.rejection!.reason.label}',
                  message: ticket.rejection!.note ?? 'Tanpa catatan tambahan.',
                  tone: palette.danger,
                ),
              ],
              const SizedBox(height: Gaps.xl),
              const SectionHeader(title: 'Pelapor'),
              const SizedBox(height: Gaps.md),
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.xs),
                  leading: CircleAvatar(
                    backgroundColor: ticket.anonymous ? palette.neutral.container : palette.info.container,
                    child: Icon(
                      ticket.anonymous ? Icons.visibility_off_outlined : Icons.person_outline_rounded,
                      color: ticket.anonymous ? palette.neutral.main : palette.info.main,
                    ),
                  ),
                  title: Text(ticket.reporter?.name ?? 'Identitas dirahasiakan'),
                  subtitle: Text(
                    ticket.anonymous
                        ? 'Gunakan "Minta data" untuk berkomunikasi dengan pelapor.'
                        : 'Kelas ${ticket.reporter?.kelas ?? '-'}',
                  ),
                  trailing: ticket.contactWhatsapp == null
                      ? null
                      : IconButton.filledTonal(
                          tooltip: 'Hubungi lewat WhatsApp',
                          onPressed: () => _openWhatsapp(context, ticket.contactWhatsapp!),
                          icon: const Icon(Icons.chat_outlined),
                        ),
                ),
              ),
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
                      if (details.role != null)
                        DetailRow(
                          icon: Icons.person_search_outlined,
                          label: 'Peran pelapor',
                          value: details.role == 'korban' ? 'Korban' : 'Saksi',
                        ),
                      if (details.frequency != null)
                        DetailRow(icon: Icons.repeat_rounded, label: 'Frekuensi', value: details.frequency!),
                      if (details.involved != null)
                        DetailRow(icon: Icons.groups_outlined, label: 'Pihak terlibat', value: details.involved!),
                      if (ticket.attachments.isNotEmpty) ...[
                        const SizedBox(height: Gaps.md),
                        AttachmentGallery(attachments: ticket.attachments),
                      ],
                    ],
                  ),
                ),
              ),
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
                        Text(ticket.resolution!.note),
                        const SizedBox(height: Gaps.sm),
                        AttachmentGallery(attachments: ticket.resolution!.attachments),
                        const SizedBox(height: Gaps.sm),
                        if (ticket.rating != null) ...[
                          RatingStars(value: ticket.rating!.score, size: 22),
                          if (ticket.rating!.comment != null) Text('"${ticket.rating!.comment}"', style: muted),
                        ] else
                          Text('Belum dinilai pelapor.', style: muted),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: Gaps.xl),
              const SectionHeader(title: 'Riwayat'),
              const SizedBox(height: Gaps.md),
              AsyncValueView(
                value: timeline,
                loading: const Padding(padding: EdgeInsets.all(Gaps.xl), child: LoadingView()),
                data: (events) => TicketTimeline(events: events),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
