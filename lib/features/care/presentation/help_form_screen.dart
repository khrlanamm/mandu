import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/errors.dart';
import '../../auth/application/session_controller.dart';
import '../data/care_repository.dart';
import '../domain/care.dart';
import 'widgets/care_widgets.dart';

final _whatsappPattern = RegExp(r'^\+?\d{9,15}$');

class HelpFormScreen extends ConsumerStatefulWidget {
  const HelpFormScreen({super.key});

  @override
  ConsumerState<HelpFormScreen> createState() => _HelpFormScreenState();
}

class _HelpFormScreenState extends ConsumerState<HelpFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _whatsapp = TextEditingController();
  final _note = TextEditingController();
  final _needs = <String>{};
  HelpUrgency _urgency = HelpUrgency.biasa;
  ContactMethod _method = ContactMethod.chat;
  ContactTime _time = ContactTime.kapanSaja;
  bool _busy = false;

  @override
  void dispose() {
    _whatsapp.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit(String schoolId) async {
    if (_needs.isEmpty) {
      showSnack(context, 'Pilih setidaknya satu kebutuhan.', error: true);
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final result = await ref.read(careRepositoryProvider).requestHelp(
            schoolId,
            HelpDraft(
              needs: _needs.toList(),
              urgency: _urgency,
              contactMethod: _method,
              contactTime: _time,
              whatsapp: _whatsapp.text,
              note: _note.text,
            ),
          );
      if (mounted) context.go(Routes.studentHelpDetail(result.requestId));
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      showSnack(context, describeError(error), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    final tone = context.palette.bantuan;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);

    return Scaffold(
      appBar: AppBar(title: const Text('Minta bantuan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.sm, Gaps.xl, Gaps.xxl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Apa yang kamu butuhkan?', style: context.textStyles.titleMedium),
                  Text('Boleh pilih lebih dari satu. Kamu tidak perlu menceritakan detailnya sekarang.', style: muted),
                  const SizedBox(height: Gaps.md),
                  Wrap(
                    spacing: Gaps.sm,
                    runSpacing: Gaps.sm,
                    children: [
                      for (final entry in kHelpNeeds.entries)
                        FilterChip(
                          label: Text(entry.value),
                          selected: _needs.contains(entry.key),
                          onSelected: _busy
                              ? null
                              : (selected) => setState(() => selected ? _needs.add(entry.key) : _needs.remove(entry.key)),
                        ),
                    ],
                  ),
                  const SizedBox(height: Gaps.xl),
                  Text('Seberapa mendesak?', style: context.textStyles.titleMedium),
                  const SizedBox(height: Gaps.md),
                  for (final urgency in HelpUrgency.values) ...[
                    Material(
                      color: _urgency == urgency ? tone.container : context.colors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Radii.md),
                        side: BorderSide(color: _urgency == urgency ? tone.main : context.colors.outlineVariant),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        enabled: !_busy,
                        onTap: () => setState(() => _urgency = urgency),
                        title: Text(urgency.label),
                        subtitle: Text(urgency.description),
                        trailing: _urgency == urgency ? Icon(Icons.check_circle_rounded, color: tone.main) : null,
                      ),
                    ),
                    const SizedBox(height: Gaps.sm),
                  ],
                  if (_urgency == HelpUrgency.darurat) ...[
                    const SizedBox(height: Gaps.sm),
                    const EmergencyContactsCard(),
                  ],
                  const SizedBox(height: Gaps.xl),
                  Text('Cara dihubungi', style: context.textStyles.titleMedium),
                  const SizedBox(height: Gaps.md),
                  SegmentedButton<ContactMethod>(
                    segments: [
                      for (final method in ContactMethod.values)
                        ButtonSegment(value: method, label: Text(method.label), icon: Icon(method.icon)),
                    ],
                    selected: {_method},
                    onSelectionChanged: _busy ? null : (selection) => setState(() => _method = selection.first),
                  ),
                  if (_method == ContactMethod.whatsapp) ...[
                    const SizedBox(height: Gaps.lg),
                    TextFormField(
                      controller: _whatsapp,
                      enabled: !_busy,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: 'Nomor WhatsApp', prefixIcon: Icon(Icons.phone_outlined)),
                      validator: (value) {
                        final number = (value ?? '').replaceAll(RegExp(r'[\s-]'), '');
                        if (_method != ContactMethod.whatsapp) return null;
                        return _whatsappPattern.hasMatch(number) ? null : 'Isi nomor WhatsApp yang bisa dihubungi.';
                      },
                    ),
                  ],
                  const SizedBox(height: Gaps.lg),
                  DropdownButtonFormField<ContactTime>(
                    initialValue: _time,
                    decoration: const InputDecoration(labelText: 'Waktu yang nyaman'),
                    items: [for (final time in ContactTime.values) DropdownMenuItem(value: time, child: Text(time.label))],
                    onChanged: _busy ? null : (value) => setState(() => _time = value ?? _time),
                  ),
                  const SizedBox(height: Gaps.lg),
                  TextFormField(
                    controller: _note,
                    enabled: !_busy,
                    minLines: 2,
                    maxLines: 6,
                    maxLength: 1000,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Ingin menambahkan sesuatu? (opsional)',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: Gaps.lg),
                  Text(
                    'Permintaan ini hanya dibaca guru BK sekolahmu. Guru dan staf lain tidak bisa melihatnya.',
                    style: muted,
                  ),
                  const SizedBox(height: Gaps.lg),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: tone.main, foregroundColor: tone.onMain),
                    onPressed: _busy || schoolId == null ? null : () => _submit(schoolId),
                    icon: _busy ? const ButtonSpinner(color: Colors.white) : const Icon(Icons.send_rounded),
                    label: const Text('Kirim permintaan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
