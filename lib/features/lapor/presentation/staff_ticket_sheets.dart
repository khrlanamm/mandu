import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/tokens.dart';
import '../../../core/domain/catalog.dart';
import '../../../core/files/pending_attachment.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/school.dart';
import '../data/ticket_repository.dart';
import '../domain/ticket.dart';
import 'widgets/ticket_widgets.dart';

/// Unit bawaan untuk kategori: unit aktif yang menangani kategori, lalu unit bawaan katalog.
String? defaultUnitFor(List<SchoolUnit> units, String category) {
  final active = units.where((unit) => unit.active).toList();
  for (final unit in active) {
    if (unit.categories.contains(category)) return unit.id;
  }
  final fallback = reportCategory(category)?.defaultUnitId;
  if (active.any((unit) => unit.id == fallback)) return fallback;
  return active.firstOrNull?.id;
}

class ForwardSheet extends ConsumerStatefulWidget {
  const ForwardSheet({super.key, required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<ForwardSheet> createState() => _ForwardSheetState();
}

class _ForwardSheetState extends ConsumerState<ForwardSheet> with ActionSheetState {
  final _message = TextEditingController();
  late String _category = widget.ticket.category;
  late String _subcategory = widget.ticket.subcategory;
  late TicketPriority _priority = widget.ticket.priority;
  String? _unitId;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  void _changeCategory(String category) {
    final units = ref.read(schoolUnitsProvider(widget.ticket.schoolId)).value ?? const [];
    setState(() {
      _category = category;
      _subcategory = category == widget.ticket.category ? widget.ticket.subcategory : reportCategory(category)!.subcategories.last.key;
      _unitId = defaultUnitFor(units, category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    final units = (ref.watch(schoolUnitsProvider(ticket.schoolId)).value ?? const <SchoolUnit>[])
        .where((unit) => unit.active)
        .toList();
    final unitId = _unitId ?? defaultUnitFor(units, _category);
    final category = reportCategory(_category)!;

    return ActionSheet(
      title: 'Verifikasi & teruskan',
      description: 'Laporan dinyatakan valid dan diteruskan ke unit penangan. Pelapor mendapat notifikasi.',
      submitLabel: 'Teruskan laporan',
      busy: busy,
      error: error,
      onSubmit: unitId == null
          ? null
          : () => submit(
                () => ref.read(ticketRepositoryProvider).forward(
                      schoolId: ticket.schoolId,
                      ticketId: ticket.id,
                      unitId: unitId,
                      category: _category == ticket.category ? null : _category,
                      subcategory: _category == ticket.category && _subcategory == ticket.subcategory ? null : _subcategory,
                      priority: _priority == ticket.priority ? null : _priority,
                      message: _message.text,
                    ),
                successMessage: 'Laporan diteruskan.',
              ),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _category,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Kategori'),
          items: [
            for (final entry in kReportCategories)
              DropdownMenuItem(
                value: entry.key,
                child: Text(entry.key == ticket.suggestedCategory ? '${entry.label} (disarankan)' : entry.label),
              ),
          ],
          onChanged: busy ? null : (value) => _changeCategory(value ?? _category),
        ),
        const SizedBox(height: Gaps.lg),
        DropdownButtonFormField<String>(
          key: ValueKey('sub-$_category'),
          initialValue: category.subcategories.any((entry) => entry.key == _subcategory) ? _subcategory : null,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Jenis masalah'),
          items: [
            for (final entry in category.subcategories) DropdownMenuItem(value: entry.key, child: Text(entry.label)),
          ],
          onChanged: busy ? null : (value) => setState(() => _subcategory = value ?? _subcategory),
        ),
        const SizedBox(height: Gaps.lg),
        DropdownButtonFormField<String>(
          key: ValueKey('unit-$_category-${units.length}'),
          initialValue: unitId,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Unit penangan',
            helperText: units.isEmpty ? 'Belum ada unit aktif. Atur unit di menu Sekolah.' : null,
          ),
          items: [for (final unit in units) DropdownMenuItem(value: unit.id, child: Text(unit.name))],
          onChanged: busy ? null : (value) => setState(() => _unitId = value),
        ),
        const SizedBox(height: Gaps.lg),
        Text('Prioritas', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: Gaps.sm),
        SegmentedButton<TicketPriority>(
          segments: [
            for (final priority in TicketPriority.values) ButtonSegment(value: priority, label: Text(priority.label)),
          ],
          selected: {_priority},
          onSelectionChanged: busy ? null : (selection) => setState(() => _priority = selection.first),
        ),
        const SizedBox(height: Gaps.lg),
        TextField(
          controller: _message,
          enabled: !busy,
          maxLength: 500,
          decoration: const InputDecoration(labelText: 'Pesan untuk pelapor (opsional)'),
        ),
      ],
    );
  }
}

class RequestInfoSheet extends ConsumerStatefulWidget {
  const RequestInfoSheet({super.key, required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<RequestInfoSheet> createState() => _RequestInfoSheetState();
}

class _RequestInfoSheetState extends ConsumerState<RequestInfoSheet> with ActionSheetState {
  final _message = TextEditingController();

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: 'Minta data tambahan',
      description: 'Pelapor diminta melengkapi laporan. Pesan ini terlihat oleh pelapor.',
      submitLabel: 'Kirim permintaan',
      busy: busy,
      error: error,
      onSubmit: () {
        if (_message.text.trim().length < 5) return fail('Tuliskan data yang perlu dilengkapi.');
        submit(
          () => ref.read(ticketRepositoryProvider).requestInfo(
                schoolId: widget.ticket.schoolId,
                ticketId: widget.ticket.id,
                message: _message.text,
              ),
          successMessage: 'Permintaan data dikirim ke pelapor.',
        );
      },
      children: [
        TextField(
          controller: _message,
          enabled: !busy,
          minLines: 3,
          maxLines: 6,
          maxLength: 500,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Data yang dibutuhkan',
            hintText: 'Contoh: Mohon lampirkan foto kerusakan dan sebutkan nomor ruangannya.',
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}

class RejectSheet extends ConsumerStatefulWidget {
  const RejectSheet({super.key, required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<RejectSheet> createState() => _RejectSheetState();
}

class _RejectSheetState extends ConsumerState<RejectSheet> with ActionSheetState {
  final _message = TextEditingController();
  RejectReason? _reason;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: 'Tolak laporan',
      description: 'Laporan ditutup dan pelapor menerima alasannya.',
      submitLabel: 'Tolak laporan',
      destructive: true,
      busy: busy,
      error: error,
      onSubmit: () {
        final reason = _reason;
        if (reason == null) return fail('Pilih alasan penolakan.');
        submit(
          () => ref.read(ticketRepositoryProvider).reject(
                schoolId: widget.ticket.schoolId,
                ticketId: widget.ticket.id,
                reason: reason,
                message: _message.text,
              ),
          successMessage: 'Laporan ditolak.',
        );
      },
      children: [
        Wrap(
          spacing: Gaps.sm,
          runSpacing: Gaps.sm,
          children: [
            for (final reason in RejectReason.values)
              ChoiceChip(
                label: Text(reason.label),
                selected: _reason == reason,
                onSelected: busy ? null : (_) => setState(() => _reason = reason),
              ),
          ],
        ),
        const SizedBox(height: Gaps.lg),
        TextField(
          controller: _message,
          enabled: !busy,
          maxLength: 500,
          minLines: 2,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Penjelasan untuk pelapor (opsional)', alignLabelWithHint: true),
        ),
      ],
    );
  }
}

class ProgressSheet extends ConsumerStatefulWidget {
  const ProgressSheet({super.key, required this.ticket, required this.internalOnly, required this.canAttach});

  final Ticket ticket;

  /// Hanya catatan internal (verifikator yang bukan unit penangan).
  final bool internalOnly;

  /// Dokumentasi hanya boleh diunggah admin atau unit penangan (storage.rules).
  final bool canAttach;

  @override
  ConsumerState<ProgressSheet> createState() => _ProgressSheetState();
}

class _ProgressSheetState extends ConsumerState<ProgressSheet> with ActionSheetState {
  final _message = TextEditingController();
  final _uploaded = <PendingAttachment, TicketAttachment>{};
  late bool _internal = widget.internalOnly;
  List<PendingAttachment> _files = [];

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  void _send() {
    if (_message.text.trim().length < 3) return fail('Tuliskan perkembangan penanganan.');
    final repository = ref.read(ticketRepositoryProvider);
    final ticket = widget.ticket;
    submit(() async {
      final attachments = await uploadPending(
        repository: repository,
        schoolId: ticket.schoolId,
        ticketId: ticket.id,
        folder: AttachmentFolder.tindakLanjut,
        files: _files,
        uploaded: _uploaded,
      );
      await repository.addProgress(
        schoolId: ticket.schoolId,
        ticketId: ticket.id,
        message: _message.text,
        visibility: _internal ? TimelineVisibility.internal : TimelineVisibility.public,
        attachments: attachments,
      );
    }, successMessage: _internal ? 'Catatan internal disimpan.' : 'Perkembangan dikirim ke pelapor.');
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: widget.internalOnly ? 'Catatan internal' : 'Tambah perkembangan',
      description: _internal
          ? 'Hanya terlihat oleh staf sekolah, tidak oleh pelapor.'
          : 'Terlihat oleh pelapor. Status berubah menjadi "Sedang diproses".',
      submitLabel: _internal ? 'Simpan catatan' : 'Kirim perkembangan',
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
          decoration: const InputDecoration(labelText: 'Catatan', alignLabelWithHint: true),
        ),
        if (!widget.internalOnly)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _internal,
            onChanged: busy ? null : (value) => setState(() => _internal = value),
            title: const Text('Hanya untuk staf'),
            subtitle: const Text('Jadikan catatan internal'),
          ),
        if (widget.canAttach) ...[
          const SizedBox(height: Gaps.sm),
          AttachmentPickerField(files: _files, enabled: !busy, onChanged: (files) => setState(() => _files = files)),
        ],
      ],
    );
  }
}

class ResolveSheet extends ConsumerStatefulWidget {
  const ResolveSheet({super.key, required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<ResolveSheet> createState() => _ResolveSheetState();
}

class _ResolveSheetState extends ConsumerState<ResolveSheet> with ActionSheetState {
  final _note = TextEditingController();
  final _uploaded = <PendingAttachment, TicketAttachment>{};
  List<PendingAttachment> _files = [];

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _send() {
    if (_note.text.trim().length < 10) return fail('Jelaskan tindak lanjut minimal 10 karakter.');
    final repository = ref.read(ticketRepositoryProvider);
    final ticket = widget.ticket;
    submit(() async {
      final attachments = await uploadPending(
        repository: repository,
        schoolId: ticket.schoolId,
        ticketId: ticket.id,
        folder: AttachmentFolder.tindakLanjut,
        files: _files,
        uploaded: _uploaded,
      );
      await repository.resolve(schoolId: ticket.schoolId, ticketId: ticket.id, note: _note.text, attachments: attachments);
    }, successMessage: 'Laporan diselesaikan. Pelapor diminta memberi penilaian.');
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: 'Selesaikan laporan',
      description: 'Ringkas tindakan yang sudah dilakukan. Catatan dan dokumentasi terlihat oleh pelapor.',
      submitLabel: 'Tandai selesai',
      busy: busy,
      error: error,
      onSubmit: _send,
      children: [
        TextField(
          controller: _note,
          enabled: !busy,
          minLines: 3,
          maxLines: 8,
          maxLength: 2000,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Tindak lanjut',
            hintText: 'Contoh: Tiga kursi sudah diganti dan kelas dicek ulang oleh petugas sarpras.',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: Gaps.sm),
        Text('Dokumentasi (disarankan)', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: Gaps.sm),
        AttachmentPickerField(files: _files, enabled: !busy, onChanged: (files) => setState(() => _files = files)),
      ],
    );
  }
}

class ReassignSheet extends ConsumerStatefulWidget {
  const ReassignSheet({super.key, required this.ticket});

  final Ticket ticket;

  @override
  ConsumerState<ReassignSheet> createState() => _ReassignSheetState();
}

class _ReassignSheetState extends ConsumerState<ReassignSheet> with ActionSheetState {
  final _message = TextEditingController();
  String? _unitId;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    final units = (ref.watch(schoolUnitsProvider(ticket.schoolId)).value ?? const <SchoolUnit>[])
        .where((unit) => unit.active && unit.id != ticket.unitId)
        .toList();
    return ActionSheet(
      title: 'Alihkan ke unit lain',
      description: 'Saat ini ditangani ${ticket.unitName ?? '-'}. Unit baru mendapat notifikasi.',
      submitLabel: 'Alihkan',
      busy: busy,
      error: error,
      onSubmit: () {
        final unitId = _unitId;
        if (unitId == null) return fail('Pilih unit tujuan.');
        submit(
          () => ref.read(ticketRepositoryProvider).reassign(
                schoolId: ticket.schoolId,
                ticketId: ticket.id,
                unitId: unitId,
                message: _message.text,
              ),
          successMessage: 'Laporan dialihkan.',
        );
      },
      children: [
        DropdownButtonFormField<String>(
          initialValue: _unitId,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Unit tujuan'),
          items: [for (final unit in units) DropdownMenuItem(value: unit.id, child: Text(unit.name))],
          onChanged: busy ? null : (value) => setState(() => _unitId = value),
        ),
        const SizedBox(height: Gaps.lg),
        TextField(
          controller: _message,
          enabled: !busy,
          maxLength: 500,
          decoration: const InputDecoration(labelText: 'Alasan (opsional)'),
        ),
      ],
    );
  }
}
