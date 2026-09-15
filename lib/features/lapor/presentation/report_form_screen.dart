import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/catalog.dart';
import '../../../core/errors.dart';
import '../../../core/files/pending_attachment.dart';
import '../../auth/application/session_controller.dart';
import '../data/ticket_repository.dart';
import '../domain/ticket.dart';
import 'widgets/ticket_widgets.dart';

const _frequencies = ['Sekali', 'Beberapa kali', 'Terus berulang'];

final _whatsappPattern = RegExp(r'^\+?\d{9,15}$');

class ReportFormScreen extends ConsumerStatefulWidget {
  const ReportFormScreen({super.key, required this.categoryKey});

  final String categoryKey;

  @override
  ConsumerState<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends ConsumerState<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _location = TextEditingController();
  final _involved = TextEditingController();
  final _whatsapp = TextEditingController();
  final _uploaded = <PendingAttachment, TicketAttachment>{};

  late final ReportCategory? _category = reportCategory(widget.categoryKey);
  late bool _anonymous = _category?.isSafety ?? false;
  late String? _subcategory = (_category?.subcategories.length ?? 0) == 1 ? _category!.subcategories.first.key : null;
  String? _ticketId;
  DateTime? _date;
  TimeOfDay? _time;
  String? _role;
  String? _frequency;
  List<PendingAttachment> _files = [];
  String? _progress;

  bool get _busy => _progress != null;

  @override
  void dispose() {
    for (final controller in [_title, _description, _location, _involved, _whatsapp]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time ?? TimeOfDay.now());
    if (picked != null) setState(() => _time = picked);
  }

  String? get _timeText =>
      _time == null ? null : '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}';

  Future<void> _submit(ReportCategory category, String schoolId) async {
    if (_subcategory == null) {
      showSnack(context, 'Pilih jenis masalah terlebih dahulu.', error: true);
      return;
    }
    if (!_formKey.currentState!.validate()) {
      showSnack(context, 'Periksa kembali isian yang ditandai merah.', error: true);
      return;
    }
    final confirmed = await confirmAction(
      context,
      title: 'Kirim laporan?',
      message: _anonymous
          ? 'Identitasmu dirahasiakan dari guru dan staf. Kamu tetap bisa memantau laporan ini di tab Aktivitas.'
          : 'Nama dan kelasmu akan terlihat oleh petugas yang menangani laporan ini.',
      confirmLabel: 'Kirim',
    );
    if (!confirmed || !mounted) return;

    final repository = ref.read(ticketRepositoryProvider);
    final ticketId = _ticketId ??= repository.newTicketId();
    setState(() => _progress = _files.isEmpty ? 'Mengirim laporan...' : 'Mengunggah lampiran...');
    try {
      final attachments = await uploadPending(
        repository: repository,
        schoolId: schoolId,
        ticketId: ticketId,
        folder: AttachmentFolder.lampiran,
        files: _files,
        uploaded: _uploaded,
      );
      if (mounted) setState(() => _progress = 'Mengirim laporan...');
      final result = await repository.submit(
        schoolId: schoolId,
        ticketId: ticketId,
        attachments: attachments,
        draft: ReportDraft(
          category: category.key,
          subcategory: _subcategory!,
          title: _title.text,
          description: _description.text,
          location: _location.text,
          anonymous: _anonymous,
          incidentDate: _date,
          incidentTime: _timeText,
          contactWhatsapp: _whatsapp.text,
          role: _role,
          frequency: _frequency,
          involved: _involved.text,
        ),
      );
      if (mounted) context.go(Routes.studentTicket(result.ticketId, justSubmitted: true));
    } catch (error) {
      if (!mounted) return;
      setState(() => _progress = null);
      showSnack(context, describeError(error), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = _category;
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    if (category == null || schoolId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const EmptyState(icon: Icons.search_off_rounded, title: 'Kategori tidak ditemukan'),
      );
    }
    final tone = context.palette.lapor;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);

    return PopScope(
      canPop: !_busy,
      child: Scaffold(
        appBar: AppBar(title: const Text('Buat laporan')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.sm, Gaps.xl, Gaps.xxl),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(Radii.lg)),
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.lg),
                        child: Row(
                          children: [
                            Icon(category.icon, color: tone.main),
                            const SizedBox(width: Gaps.md),
                            Expanded(
                              child: Text(category.label, style: context.textStyles.titleMedium?.copyWith(color: tone.onContainer)),
                            ),
                            TextButton(onPressed: _busy ? null : () => context.pop(), child: const Text('Ganti')),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Jenis masalah'),
                    const SizedBox(height: Gaps.sm),
                    Wrap(
                      spacing: Gaps.sm,
                      runSpacing: Gaps.sm,
                      children: [
                        for (final subcategory in category.subcategories)
                          ChoiceChip(
                            label: Text(subcategory.label),
                            selected: _subcategory == subcategory.key,
                            onSelected: _busy ? null : (_) => setState(() => _subcategory = subcategory.key),
                          ),
                      ],
                    ),
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Ceritakan kejadiannya'),
                    const SizedBox(height: Gaps.md),
                    TextFormField(
                      controller: _title,
                      enabled: !_busy,
                      maxLength: 120,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(labelText: 'Judul singkat', hintText: 'Contoh: Kursi kelas XI IPA 1 patah'),
                      validator: (value) => (value ?? '').trim().length < 5 ? 'Judul minimal 5 karakter.' : null,
                    ),
                    const SizedBox(height: Gaps.sm),
                    TextFormField(
                      controller: _description,
                      enabled: !_busy,
                      minLines: 5,
                      maxLines: 12,
                      maxLength: 5000,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: 'Apa yang terjadi?',
                        alignLabelWithHint: true,
                        hintText: category.isSafety
                            ? 'Ceritakan apa yang terjadi, di mana, dan sejak kapan. Tulis sebisamu.'
                            : 'Jelaskan masalahnya dan dampaknya bagi siswa.',
                      ),
                      validator: (value) => (value ?? '').trim().length < 10 ? 'Ceritakan minimal 10 karakter.' : null,
                    ),
                    const SizedBox(height: Gaps.sm),
                    TextFormField(
                      controller: _location,
                      enabled: !_busy,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        labelText: 'Lokasi',
                        hintText: 'Contoh: Kantin, Kelas X-2, grup WhatsApp kelas',
                        prefixIcon: Icon(Icons.place_outlined),
                      ),
                      validator: (value) => (value ?? '').trim().length < 2 ? 'Isi lokasi kejadian.' : null,
                    ),
                    const SizedBox(height: Gaps.sm),
                    Wrap(
                      spacing: Gaps.sm,
                      runSpacing: Gaps.sm,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _busy ? null : _pickDate,
                          icon: const Icon(Icons.event_outlined),
                          label: Text(_date == null ? 'Tanggal kejadian' : DateFormat('d MMM yyyy', 'id_ID').format(_date!)),
                        ),
                        OutlinedButton.icon(
                          onPressed: _busy ? null : _pickTime,
                          icon: const Icon(Icons.schedule_outlined),
                          label: Text(_timeText == null ? 'Jam (opsional)' : 'Pukul ${_timeText!.replaceAll(':', '.')}'),
                        ),
                      ],
                    ),
                    if (category.isSafety) ...[
                      const SizedBox(height: Gaps.xl),
                      const SectionHeader(title: 'Detail tambahan'),
                      const SizedBox(height: Gaps.xs),
                      Text('Semua isian di bagian ini boleh dikosongkan.', style: muted),
                      const SizedBox(height: Gaps.md),
                      SegmentedButton<String>(
                        emptySelectionAllowed: true,
                        segments: const [
                          ButtonSegment(value: 'korban', label: Text('Saya korban'), icon: Icon(Icons.person_outline_rounded)),
                          ButtonSegment(value: 'saksi', label: Text('Saya saksi'), icon: Icon(Icons.visibility_outlined)),
                        ],
                        selected: {?_role},
                        onSelectionChanged: _busy ? null : (selection) => setState(() => _role = selection.firstOrNull),
                      ),
                      const SizedBox(height: Gaps.lg),
                      DropdownButtonFormField<String>(
                        initialValue: _frequency,
                        decoration: const InputDecoration(labelText: 'Seberapa sering terjadi?'),
                        items: [for (final value in _frequencies) DropdownMenuItem(value: value, child: Text(value))],
                        onChanged: _busy ? null : (value) => setState(() => _frequency = value),
                      ),
                      const SizedBox(height: Gaps.lg),
                      TextFormField(
                        controller: _involved,
                        enabled: !_busy,
                        maxLength: 300,
                        decoration: const InputDecoration(
                          labelText: 'Pihak yang terlibat',
                          helperText: 'Tidak wajib, isi jika kamu sudah siap menyebutkan.',
                        ),
                      ),
                    ],
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Bukti pendukung'),
                    const SizedBox(height: Gaps.xs),
                    Text('Foto atau dokumen membantu sekolah memverifikasi laporan lebih cepat.', style: muted),
                    const SizedBox(height: Gaps.md),
                    AttachmentPickerField(
                      files: _files,
                      enabled: !_busy,
                      onChanged: (files) => setState(() => _files = files),
                    ),
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Privasi'),
                    const SizedBox(height: Gaps.sm),
                    Card(
                      child: Column(
                        children: [
                          SwitchListTile(
                            value: _anonymous,
                            onChanged: _busy ? null : (value) => setState(() => _anonymous = value),
                            secondary: Icon(_anonymous ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            title: const Text('Rahasiakan identitasku'),
                            subtitle: Text(
                              _anonymous
                                  ? 'Nama dan kelasmu tidak ditampilkan ke guru dan staf.'
                                  : 'Nama dan kelasmu terlihat oleh petugas yang menangani.',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(Gaps.lg, 0, Gaps.lg, Gaps.lg),
                            child: TextFormField(
                              controller: _whatsapp,
                              enabled: !_busy,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Nomor WhatsApp (opsional)',
                                prefixIcon: const Icon(Icons.phone_outlined),
                                helperMaxLines: 2,
                                helperText: _anonymous
                                    ? 'Isi hanya jika bersedia dihubungi. Nomor dapat membuat identitasmu dikenali.'
                                    : 'Isi hanya jika kamu bersedia dihubungi langsung.',
                              ),
                              validator: (value) {
                                final number = (value ?? '').replaceAll(RegExp(r'[\s-]'), '');
                                return number.isEmpty || _whatsappPattern.hasMatch(number) ? null : 'Nomor WhatsApp tidak valid.';
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Gaps.xl),
                    FilledButton.icon(
                      onPressed: _busy ? null : () => _submit(category, schoolId),
                      icon: _busy ? const ButtonSpinner(color: Colors.white) : const Icon(Icons.send_rounded),
                      label: Text(_progress ?? 'Kirim laporan'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
