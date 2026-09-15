import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design/palette.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/design/widgets/feedback.dart';
import '../../../../core/design/widgets/layout.dart';
import '../../../lapor/presentation/widgets/ticket_widgets.dart';
import '../../data/aspiration_repository.dart';
import '../../domain/aspiration.dart';

extension AspirationStatusStyle on AspirationStatus {
  ToneColors tone(ManduPalette palette) => switch (this) {
        AspirationStatus.diterima => palette.info,
        AspirationStatus.ditinjau => palette.warning,
        AspirationStatus.ditindaklanjuti => palette.curhat,
        AspirationStatus.direalisasikan => palette.success,
        AspirationStatus.belumDapat => palette.neutral,
      };

  IconData get icon => switch (this) {
        AspirationStatus.diterima => Icons.inbox_rounded,
        AspirationStatus.ditinjau => Icons.manage_search_rounded,
        AspirationStatus.ditindaklanjuti => Icons.directions_run_rounded,
        AspirationStatus.direalisasikan => Icons.celebration_rounded,
        AspirationStatus.belumDapat => Icons.hourglass_disabled_rounded,
      };

  String get description => switch (this) {
        AspirationStatus.diterima => 'Aspirasi sudah masuk dan menunggu ditinjau sekolah.',
        AspirationStatus.ditinjau => 'Sekolah sedang mempelajari aspirasi ini.',
        AspirationStatus.ditindaklanjuti => 'Sekolah sedang menjalankan tindak lanjut.',
        AspirationStatus.direalisasikan => 'Aspirasi sudah diwujudkan. Terima kasih atas masukannya!',
        AspirationStatus.belumDapat => 'Aspirasi belum dapat diwujudkan saat ini. Lihat tanggapan sekolah.',
      };
}

class AspirationStatusPill extends StatelessWidget {
  const AspirationStatusPill({super.key, required this.status});

  final AspirationStatus status;

  @override
  Widget build(BuildContext context) =>
      StatusPill(label: status.label, tone: status.tone(context.palette), icon: status.icon);
}

class AspirationCard extends StatelessWidget {
  const AspirationCard({super.key, required this.aspiration, required this.onTap, this.staffView = false, this.footer});

  final Aspiration aspiration;
  final VoidCallback onTap;

  /// Tampilkan asal (tamu/siswa), penanda kata kasar, dan status papan.
  final bool staffView;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
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
                  Icon(aspiration.type.icon, size: 18, color: palette.aspirasi.main),
                  const SizedBox(width: Gaps.xs),
                  Expanded(
                    child: Text(
                      '${aspiration.type.label} · ${aspiration.topicLabel}',
                      style: context.textStyles.labelMedium?.copyWith(color: palette.aspirasi.onContainer),
                    ),
                  ),
                  AspirationStatusPill(status: aspiration.status),
                ],
              ),
              const SizedBox(height: Gaps.sm),
              Text(aspiration.title, style: context.textStyles.titleSmall),
              const SizedBox(height: 2),
              Text(aspiration.content, maxLines: 3, overflow: TextOverflow.ellipsis, style: context.textStyles.bodyMedium),
              const SizedBox(height: Gaps.sm),
              Wrap(
                spacing: Gaps.sm,
                runSpacing: Gaps.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (staffView) ...[
                    StatusPill(
                      label: aspiration.fromGuest ? 'Tamu' : (aspiration.anonymous ? 'Siswa · rahasia' : 'Siswa'),
                      tone: palette.neutral,
                      icon: aspiration.fromGuest ? Icons.public_rounded : Icons.person_outline_rounded,
                    ),
                    if (aspiration.flagged) StatusPill(label: 'Kata kasar disamarkan', tone: palette.danger, icon: Icons.flag_outlined),
                    if (aspiration.board == BoardState.published)
                      StatusPill(label: 'Di papan · ${aspiration.supportCount} dukungan', tone: palette.aspirasi, icon: Icons.push_pin_outlined),
                  ],
                  if (aspiration.response != null)
                    StatusPill(label: 'Ada tanggapan', tone: palette.success, icon: Icons.forum_outlined),
                  if (aspiration.createdAt != null) Text(formatRelative(aspiration.createdAt!), style: muted),
                ],
              ),
              if (footer != null) ...[const SizedBox(height: Gaps.sm), footer!],
            ],
          ),
        ),
      ),
    );
  }
}

/// Tombol dukung aspirasi di papan (satu dukungan per siswa).
class SupportButton extends ConsumerStatefulWidget {
  const SupportButton({super.key, required this.aspiration});

  final Aspiration aspiration;

  @override
  ConsumerState<SupportButton> createState() => _SupportButtonState();
}

class _SupportButtonState extends ConsumerState<SupportButton> {
  bool _busy = false;

  Future<void> _toggle(bool supported) async {
    setState(() => _busy = true);
    await runGuarded(
      context,
      () => ref.read(aspirationRepositoryProvider).support(
            schoolId: widget.aspiration.schoolId,
            aspirationId: widget.aspiration.id,
            support: !supported,
          ),
    );
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final aspiration = widget.aspiration;
    final supported = ref.watch(aspirationSupportedProvider(aspiration.schoolId, aspiration.id)).value ?? false;
    final label = Text('${supported ? 'Didukung' : 'Dukung'} · ${aspiration.supportCount}');
    final icon = _busy
        ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
        : Icon(supported ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined);
    final onPressed = _busy ? null : () => _toggle(supported);
    final style = ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(0, 40)));
    return supported
        ? FilledButton.tonalIcon(style: style, onPressed: onPressed, icon: icon, label: label)
        : OutlinedButton.icon(style: style, onPressed: onPressed, icon: icon, label: label);
  }
}

/// Formulir aspirasi untuk siswa (dengan opsi rahasia) dan tamu.
class AspirationForm extends StatefulWidget {
  const AspirationForm({super.key, required this.onSubmit, required this.showAnonymous, this.intro});

  final Future<void> Function(AspirationDraft draft) onSubmit;
  final bool showAnonymous;
  final Widget? intro;

  @override
  State<AspirationForm> createState() => _AspirationFormState();
}

class _AspirationFormState extends State<AspirationForm> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();
  AspirationType _type = AspirationType.saran;
  String? _topic;
  bool _anonymous = false;
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_topic == null) {
      showSnack(context, 'Pilih topik aspirasi.', error: true);
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await widget.onSubmit(
        AspirationDraft(type: _type, topic: _topic!, title: _title.text, content: _content.text, anonymous: _anonymous),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tone = context.palette.aspirasi;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ?widget.intro,
          const SectionHeader(title: 'Jenis aspirasi'),
          const SizedBox(height: Gaps.sm),
          for (final type in AspirationType.values) ...[
            Material(
              color: _type == type ? tone.container : context.colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.md),
                side: BorderSide(color: _type == type ? tone.main : context.colors.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                enabled: !_busy,
                onTap: () => setState(() => _type = type),
                leading: Icon(type.icon, color: tone.main),
                title: Text(type.label),
                subtitle: Text(type.description),
                trailing: _type == type ? Icon(Icons.check_circle_rounded, color: tone.main) : null,
              ),
            ),
            const SizedBox(height: Gaps.sm),
          ],
          const SizedBox(height: Gaps.lg),
          const SectionHeader(title: 'Topik'),
          const SizedBox(height: Gaps.sm),
          Wrap(
            spacing: Gaps.sm,
            runSpacing: Gaps.sm,
            children: [
              for (final entry in kAspirationTopics.entries)
                ChoiceChip(
                  label: Text(entry.value),
                  selected: _topic == entry.key,
                  onSelected: _busy ? null : (_) => setState(() => _topic = entry.key),
                ),
            ],
          ),
          const SizedBox(height: Gaps.xl),
          TextFormField(
            controller: _title,
            enabled: !_busy,
            maxLength: 120,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Judul', hintText: 'Contoh: Tambah tempat parkir sepeda'),
            validator: (value) => (value ?? '').trim().length < 5 ? 'Judul minimal 5 karakter.' : null,
          ),
          const SizedBox(height: Gaps.sm),
          TextFormField(
            controller: _content,
            enabled: !_busy,
            minLines: 5,
            maxLines: 12,
            maxLength: 3000,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Isi aspirasi',
              alignLabelWithHint: true,
              hintText: 'Jelaskan apa yang kamu usulkan, alasannya, dan manfaatnya bagi siswa.',
            ),
            validator: (value) => (value ?? '').trim().length < 10 ? 'Tuliskan minimal 10 karakter.' : null,
          ),
          if (widget.showAnonymous)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _anonymous,
              onChanged: _busy ? null : (value) => setState(() => _anonymous = value),
              title: const Text('Rahasiakan identitasku'),
              subtitle: Text(
                _anonymous
                    ? 'Admin sekolah tidak melihat nama dan kelasmu. Kamu tetap bisa memantau tanggapan.'
                    : 'Nama dan kelasmu terlihat oleh admin sekolah, tidak di papan aspirasi.',
              ),
            ),
          const SizedBox(height: Gaps.lg),
          FilledButton.icon(
            onPressed: _busy ? null : _submit,
            icon: _busy ? const ButtonSpinner(color: Colors.white) : const Icon(Icons.send_rounded),
            label: const Text('Kirim aspirasi'),
          ),
        ],
      ),
    );
  }
}
