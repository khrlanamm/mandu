import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/design/palette.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/design/widgets/feedback.dart';
import '../../../../core/design/widgets/layout.dart';
import '../../../../core/domain/catalog.dart';
import '../../../../core/domain/roles.dart';
import '../../../../core/errors.dart';
import '../../../../core/files/pending_attachment.dart';
import '../../data/ticket_repository.dart';
import '../../domain/ticket.dart';

String formatDateTime(DateTime date) => DateFormat('d MMM yyyy, HH.mm', 'id_ID').format(date);

String formatDate(DateTime date) => DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);

String formatRelative(DateTime date) => timeago.format(date, locale: 'id');

/// Tanggal kejadian `yyyy-MM-dd` + jam `HH:mm` dari formulir.
String? formatIncident(String? date, String? time) {
  final parsed = date == null ? null : DateTime.tryParse(date);
  if (parsed == null) return time;
  final day = DateFormat('d MMMM yyyy', 'id_ID').format(parsed);
  return time == null ? day : '$day, pukul ${time.replaceAll(':', '.')}';
}

extension TicketStatusStyle on TicketStatus {
  ToneColors tone(ManduPalette palette) => switch (this) {
        TicketStatus.menungguVerifikasi => palette.info,
        TicketStatus.perluDilengkapi => palette.warning,
        TicketStatus.diteruskan => palette.bantuan,
        TicketStatus.diproses => palette.curhat,
        TicketStatus.selesai => palette.success,
        TicketStatus.ditolak => palette.danger,
        TicketStatus.dibatalkan => palette.neutral,
      };

  IconData get icon => switch (this) {
        TicketStatus.menungguVerifikasi => Icons.hourglass_top_rounded,
        TicketStatus.perluDilengkapi => Icons.edit_note_rounded,
        TicketStatus.diteruskan => Icons.forward_rounded,
        TicketStatus.diproses => Icons.construction_rounded,
        TicketStatus.selesai => Icons.check_circle_rounded,
        TicketStatus.ditolak => Icons.block_rounded,
        TicketStatus.dibatalkan => Icons.cancel_outlined,
      };
}

class TicketStatusPill extends StatelessWidget {
  const TicketStatusPill({super.key, required this.status});

  final TicketStatus status;

  @override
  Widget build(BuildContext context) =>
      StatusPill(label: status.label, tone: status.tone(context.palette), icon: status.icon);
}

class PriorityPill extends StatelessWidget {
  const PriorityPill({super.key, required this.priority});

  final TicketPriority priority;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return StatusPill(
      label: 'Prioritas ${priority.label.toLowerCase()}',
      icon: priority == TicketPriority.darurat ? Icons.priority_high_rounded : null,
      tone: switch (priority) {
        TicketPriority.darurat => palette.danger,
        TicketPriority.tinggi => palette.warning,
        TicketPriority.normal => palette.neutral,
      },
    );
  }
}

/// Penanda batas waktu (SLA) tahap yang sedang berjalan.
class SlaPill extends StatelessWidget {
  const SlaPill({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final due = ticket.dueAt;
    if (due == null) return const SizedBox.shrink();
    final palette = context.palette;
    if (ticket.isOverdue()) {
      return StatusPill(label: 'Lewat batas ${formatRelative(due)}', tone: palette.danger, icon: Icons.timer_off_outlined);
    }
    final soon = due.difference(DateTime.now()) < const Duration(hours: 6);
    return StatusPill(
      label: 'Batas ${DateFormat('d MMM, HH.mm', 'id_ID').format(due)}',
      tone: soon ? palette.warning : palette.neutral,
      icon: Icons.schedule_rounded,
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket, required this.onTap, this.staffView = false});

  final Ticket ticket;
  final VoidCallback onTap;

  /// Tampilkan prioritas, batas waktu, dan unit (untuk staf).
  final bool staffView;

  @override
  Widget build(BuildContext context) {
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    final created = ticket.createdAt;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Gaps.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ticket.number,
                      style: context.textStyles.labelMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                  TicketStatusPill(status: ticket.status),
                ],
              ),
              const SizedBox(height: Gaps.sm),
              Text(ticket.title, style: context.textStyles.titleSmall, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text('${ticket.categoryLabel} · ${ticket.subcategoryLabel}', style: muted),
              const SizedBox(height: Gaps.sm),
              Wrap(
                spacing: Gaps.sm,
                runSpacing: Gaps.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (staffView && ticket.priority != TicketPriority.normal) PriorityPill(priority: ticket.priority),
                  if (staffView && !ticket.status.isClosed) SlaPill(ticket: ticket),
                  if (staffView && ticket.unitName != null)
                    StatusPill(label: ticket.unitName!, tone: context.palette.neutral, icon: Icons.apartment_rounded),
                  if (created != null) Text(formatRelative(created), style: muted),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Alur Terkirim → Diverifikasi → Diproses → Selesai.
class TicketProgressSteps extends StatelessWidget {
  const TicketProgressSteps({super.key, required this.status});

  final TicketStatus status;

  static const _labels = ['Terkirim', 'Diverifikasi', 'Diproses', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    final active = context.palette.success.main;
    final idle = context.colors.outlineVariant;
    final step = status.step;
    return Row(
      children: [
        for (var index = 0; index < _labels.length; index++) ...[
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container(height: 3, color: index == 0 ? Colors.transparent : (index <= step ? active : idle))),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(color: index <= step ? active : idle, shape: BoxShape.circle),
                      child: index <= step ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
                    ),
                    Expanded(
                      child: Container(
                        height: 3,
                        color: index == _labels.length - 1 ? Colors.transparent : (index < step ? active : idle),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Gaps.xs),
                Text(
                  _labels[index],
                  textAlign: TextAlign.center,
                  style: context.textStyles.labelSmall?.copyWith(
                    color: index <= step ? context.colors.onSurface : context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Baris label–nilai pada detail laporan.
class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gaps.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: context.colors.onSurfaceVariant),
          const SizedBox(width: Gaps.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSurfaceVariant)),
                Text(value, style: context.textStyles.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AttachmentGallery extends ConsumerWidget {
  const AttachmentGallery({super.key, required this.attachments});

  final List<TicketAttachment> attachments;

  Future<void> _open(BuildContext context, WidgetRef ref, TicketAttachment attachment) async {
    final url = await runGuarded(context, () => ref.read(attachmentUrlProvider(attachment.path).future));
    if (url == null || !context.mounted) return;
    if (attachment.isImage) {
      await showDialog<void>(
        context: context,
        builder: (context) => Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(child: InteractiveViewer(child: Image.network(url, fit: BoxFit.contain))),
              SafeArea(
                child: IconButton(
                  tooltip: 'Tutup',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final opened = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      if (!opened && context.mounted) showSnack(context, 'Tidak ada aplikasi untuk membuka berkas ini.', error: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (attachments.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: Gaps.sm,
      runSpacing: Gaps.sm,
      children: [
        for (final attachment in attachments)
          Tooltip(
            message: attachment.name,
            child: InkWell(
              borderRadius: BorderRadius.circular(Radii.md),
              onTap: () => _open(context, ref, attachment),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Radii.md),
                child: SizedBox.square(
                  dimension: 92,
                  child: attachment.isImage
                      ? _RemoteThumbnail(path: attachment.path)
                      : _FileTile(name: attachment.name),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _RemoteThumbnail extends ConsumerWidget {
  const _RemoteThumbnail({required this.path});

  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(attachmentUrlProvider(path));
    final placeholder = ColoredBox(
      color: context.colors.surfaceContainerHigh,
      child: Icon(url.hasError ? Icons.broken_image_outlined : Icons.image_outlined, color: context.colors.onSurfaceVariant),
    );
    final value = url.value;
    if (value == null) return placeholder;
    return Image.network(value, fit: BoxFit.cover, errorBuilder: (_, _, _) => placeholder);
  }
}

class _FileTile extends StatelessWidget {
  const _FileTile({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.palette.danger.container,
      child: Padding(
        padding: const EdgeInsets.all(Gaps.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf_rounded, color: context.palette.danger.main),
            const SizedBox(height: Gaps.xs),
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textStyles.labelSmall?.copyWith(color: context.palette.danger.onContainer),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pemilih lampiran (kamera atau berkas) sebelum diunggah.
class AttachmentPickerField extends StatelessWidget {
  const AttachmentPickerField({
    super.key,
    required this.files,
    required this.onChanged,
    this.max = kMaxAttachments,
    this.enabled = true,
  });

  final List<PendingAttachment> files;
  final ValueChanged<List<PendingAttachment>> onChanged;
  final int max;
  final bool enabled;

  Future<void> _add(BuildContext context, Future<List<PendingAttachment>> Function() pick) async {
    try {
      final picked = await pick();
      if (picked.isNotEmpty) onChanged([...files, ...picked].take(max).toList());
    } catch (error) {
      if (context.mounted) showSnack(context, describeError(error), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = max - files.length;
    final canCapture = !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (files.isNotEmpty) ...[
          Wrap(
            spacing: Gaps.sm,
            runSpacing: Gaps.sm,
            children: [
              for (final file in files)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Radii.md),
                      child: SizedBox.square(
                        dimension: 84,
                        child: file.isImage ? Image.memory(file.bytes, fit: BoxFit.cover) : _FileTile(name: file.name),
                      ),
                    ),
                    Positioned(
                      top: -8,
                      right: -8,
                      child: IconButton.filledTonal(
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Hapus ${file.name}',
                        onPressed: enabled ? () => onChanged([...files]..remove(file)) : null,
                        icon: const Icon(Icons.close_rounded, size: 16),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: Gaps.md),
        ],
        Wrap(
          spacing: Gaps.sm,
          runSpacing: Gaps.sm,
          children: [
            if (canCapture)
              OutlinedButton.icon(
                onPressed: enabled && remaining > 0
                    ? () => _add(context, () async => [?await captureAttachmentPhoto()])
                    : null,
                icon: const Icon(Icons.photo_camera_outlined),
                label: const Text('Kamera'),
              ),
            OutlinedButton.icon(
              onPressed: enabled && remaining > 0 ? () => _add(context, () => pickAttachmentFiles(remaining: remaining)) : null,
              icon: const Icon(Icons.attach_file_rounded),
              label: const Text('Foto / PDF'),
            ),
          ],
        ),
        const SizedBox(height: Gaps.xs),
        Text(
          'Maksimal $max berkas, masing-masing hingga 10 MB.',
          style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

/// Unggah semua lampiran yang belum terunggah. [uploaded] menyimpan hasil agar tidak diunggah ulang saat mencoba lagi.
Future<List<TicketAttachment>> uploadPending({
  required TicketRepository repository,
  required String schoolId,
  required String ticketId,
  required AttachmentFolder folder,
  required List<PendingAttachment> files,
  required Map<PendingAttachment, TicketAttachment> uploaded,
}) async {
  final result = <TicketAttachment>[];
  for (final file in files) {
    uploaded[file] ??= await repository.uploadAttachment(schoolId: schoolId, ticketId: ticketId, folder: folder, file: file);
    result.add(uploaded[file]!);
  }
  return result;
}

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.value, this.onChanged, this.size = 36});

  final int value;
  final ValueChanged<int>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = context.palette.aspirasi.main;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var score = 1; score <= 5; score++)
          onChanged == null
              ? Icon(score <= value ? Icons.star_rounded : Icons.star_outline_rounded, color: color, size: size)
              : IconButton(
                  tooltip: 'Nilai $score',
                  onPressed: () => onChanged!(score),
                  iconSize: size,
                  icon: Icon(score <= value ? Icons.star_rounded : Icons.star_outline_rounded, color: color),
                ),
      ],
    );
  }
}

extension TimelineTypeLabel on TimelineType {
  String get title => switch (this) {
        TimelineType.dibuat => 'Laporan dikirim',
        TimelineType.dimintaMelengkapi => 'Sekolah meminta data tambahan',
        TimelineType.dilengkapi => 'Pelapor melengkapi data',
        TimelineType.diteruskan => 'Diverifikasi & diteruskan',
        TimelineType.dialihkan => 'Dialihkan ke unit lain',
        TimelineType.progres => 'Perkembangan penanganan',
        TimelineType.catatanInternal => 'Catatan internal',
        TimelineType.selesai => 'Laporan selesai',
        TimelineType.ditolak => 'Tidak dilanjutkan',
        TimelineType.dibatalkan => 'Dibatalkan',
        TimelineType.dinilai => 'Penilaian pelapor',
        TimelineType.pengingat => 'Pengingat batas waktu',
      };

  IconData get icon => switch (this) {
        TimelineType.dibuat => Icons.send_rounded,
        TimelineType.dimintaMelengkapi => Icons.help_outline_rounded,
        TimelineType.dilengkapi => Icons.edit_note_rounded,
        TimelineType.diteruskan => Icons.forward_rounded,
        TimelineType.dialihkan => Icons.alt_route_rounded,
        TimelineType.progres => Icons.construction_rounded,
        TimelineType.catatanInternal => Icons.lock_outline_rounded,
        TimelineType.selesai => Icons.check_circle_rounded,
        TimelineType.ditolak => Icons.block_rounded,
        TimelineType.dibatalkan => Icons.cancel_outlined,
        TimelineType.dinilai => Icons.star_rounded,
        TimelineType.pengingat => Icons.alarm_rounded,
      };
}

String _actorLabel(TimelineEvent event) {
  final role = switch (event.actorRole) {
    'pelapor' => 'Pelapor',
    'sistem' => 'Sistem MANDU',
    final value => SchoolRole.tryParse(value)?.label ?? value,
  };
  return event.actorName == null ? role : '${event.actorName} · $role';
}

class TicketTimeline extends StatelessWidget {
  const TicketTimeline({super.key, required this.events});

  final List<TimelineEvent> events;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      children: [
        for (var index = 0; index < events.length; index++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 36,
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: events[index].visibility == TimelineVisibility.internal
                              ? palette.neutral.container
                              : palette.info.container,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          events[index].type.icon,
                          size: 17,
                          color: events[index].visibility == TimelineVisibility.internal ? palette.neutral.main : palette.info.main,
                        ),
                      ),
                      if (index < events.length - 1)
                        Expanded(child: Container(width: 2, color: context.colors.outlineVariant)),
                    ],
                  ),
                ),
                const SizedBox(width: Gaps.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: Gaps.lg, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: Gaps.sm,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(events[index].type.title, style: context.textStyles.titleSmall),
                            if (events[index].visibility == TimelineVisibility.internal)
                              StatusPill(label: 'Hanya staf', tone: palette.neutral, icon: Icons.lock_outline_rounded),
                          ],
                        ),
                        Text(
                          [
                            _actorLabel(events[index]),
                            if (events[index].createdAt != null) formatDateTime(events[index].createdAt!),
                          ].join(' · '),
                          style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                        ),
                        if (events[index].message != null && events[index].message!.isNotEmpty) ...[
                          const SizedBox(height: Gaps.xs),
                          Text(events[index].message!, style: context.textStyles.bodyMedium),
                        ],
                        if (events[index].attachments.isNotEmpty) ...[
                          const SizedBox(height: Gaps.sm),
                          AttachmentGallery(attachments: events[index].attachments),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Kerangka bottom sheet aksi laporan.
class ActionSheet extends StatelessWidget {
  const ActionSheet({
    super.key,
    required this.title,
    required this.children,
    required this.submitLabel,
    required this.onSubmit,
    this.description,
    this.error,
    this.busy = false,
    this.destructive = false,
  });

  final String title;
  final String? description;
  final List<Widget> children;
  final String submitLabel;
  final VoidCallback? onSubmit;

  /// Pesan gagal ditampilkan di dalam sheet (snackbar tertutup oleh sheet).
  final String? error;
  final bool busy;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final danger = context.palette.danger;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Gaps.xl, 0, Gaps.xl, Gaps.xl),
        child: ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: context.textStyles.titleLarge),
              if (description != null) ...[
                const SizedBox(height: Gaps.xs),
                Text(description!, style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant)),
              ],
              const SizedBox(height: Gaps.lg),
              ...children,
              if (error != null) ...[
                const SizedBox(height: Gaps.lg),
                InfoBanner(icon: Icons.error_outline_rounded, message: error!, tone: danger),
              ],
              const SizedBox(height: Gaps.xl),
              FilledButton(
                style: destructive ? FilledButton.styleFrom(backgroundColor: danger.main, foregroundColor: danger.onMain) : null,
                onPressed: busy ? null : onSubmit,
                child: busy ? const ButtonSpinner(color: Colors.white) : Text(submitLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Status kirim untuk sheet aksi: tombol sibuk, error di dalam sheet, snackbar setelah sheet ditutup.
mixin ActionSheetState<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  bool busy = false;
  String? error;

  void fail(String message) => setState(() => error = message);

  Future<void> submit(Future<void> Function() action, {required String successMessage}) async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await action();
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context, true);
      messenger.showSnackBar(SnackBar(content: Text(successMessage)));
    } catch (caught) {
      if (mounted) {
        setState(() {
          busy = false;
          error = describeError(caught);
        });
      }
    }
  }
}

Future<bool?> showActionSheet(BuildContext context, WidgetBuilder builder) => showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: builder,
    );
