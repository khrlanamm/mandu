import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../../lapor/data/ticket_repository.dart';
import '../../lapor/presentation/widgets/ticket_widgets.dart';
import '../../schools/data/school_repository.dart';
import '../data/aspiration_repository.dart';
import '../domain/aspiration.dart';
import 'widgets/aspiration_widgets.dart';

class StaffAspirationScreen extends ConsumerWidget {
  const StaffAspirationScreen({super.key, required this.aspirationId});

  final String aspirationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    final access = ref.watch(staffTicketAccessProvider);
    if (schoolId == null || access == null) return const Scaffold(body: LoadingView());
    final aspirationAsync = ref.watch(aspirationProvider(schoolId, aspirationId));
    final aspiration = aspirationAsync.value;
    final boardEnabled = ref.watch(schoolDocProvider(schoolId)).value?.aspirationBoard ?? true;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(Routes.staffAspirations),
              ),
        title: Text(aspiration?.number ?? 'Aspirasi'),
      ),
      bottomNavigationBar: aspiration == null || !access.isVerifier
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(Gaps.md),
                child: FilledButton.icon(
                  onPressed: () => showActionSheet(
                    context,
                    (_) => _ReviewSheet(aspiration: aspiration, boardEnabled: boardEnabled),
                  ),
                  icon: const Icon(Icons.forum_rounded),
                  label: Text(aspiration.response == null ? 'Tanggapi aspirasi' : 'Perbarui tanggapan'),
                ),
              ),
            ),
      body: AsyncValueView(
        value: aspirationAsync,
        onRetry: () => ref.invalidate(aspirationProvider(schoolId, aspirationId)),
        data: (aspiration) => aspiration == null
            ? const EmptyState(icon: Icons.search_off_rounded, title: 'Aspirasi tidak ditemukan')
            : _Body(aspiration: aspiration, readOnly: !access.isVerifier),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.aspiration, required this.readOnly});

  final Aspiration aspiration;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    final identity = aspiration.fromGuest || aspiration.anonymous
        ? null
        : ref.watch(aspirationIdentityProvider(aspiration.schoolId, aspiration.id)).value;
    final sender = aspiration.fromGuest
        ? ('Tamu tanpa login', 'Dikirim lewat kode sekolah. Tidak dapat dihubungi atau dilacak.')
        : aspiration.anonymous
            ? ('Siswa (identitas dirahasiakan)', 'Pengirim tetap menerima notifikasi tanggapanmu.')
            : (identity?.name ?? 'Memuat...', identity?.kelas == null ? 'Siswa' : 'Kelas ${identity!.kelas}');

    return ListView(
      padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxl),
      children: [
        ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (readOnly) ...[
                InfoBanner(
                  icon: Icons.visibility_outlined,
                  message: 'Mode pantau: tanggapan diberikan oleh admin sekolah atau Tim Verifikasi.',
                  tone: palette.neutral,
                ),
                const SizedBox(height: Gaps.md),
              ],
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
                          AspirationStatusPill(status: aspiration.status),
                          StatusPill(label: aspiration.board.label, tone: palette.aspirasi, icon: Icons.push_pin_outlined),
                          if (aspiration.board == BoardState.published)
                            StatusPill(label: '${aspiration.supportCount} dukungan', tone: palette.success, icon: Icons.thumb_up_alt_outlined),
                        ],
                      ),
                      const SizedBox(height: Gaps.md),
                      Text(aspiration.title, style: context.textStyles.titleLarge),
                      Text('${aspiration.type.label} · ${aspiration.topicLabel}', style: muted),
                      const SizedBox(height: Gaps.md),
                      Text(aspiration.content, style: context.textStyles.bodyMedium),
                      const SizedBox(height: Gaps.sm),
                      if (aspiration.createdAt != null)
                        Text('Masuk ${formatDateTime(aspiration.createdAt!)} (${formatRelative(aspiration.createdAt!)})', style: muted),
                    ],
                  ),
                ),
              ),
              if (aspiration.flagged) ...[
                const SizedBox(height: Gaps.md),
                InfoBanner(
                  icon: Icons.flag_outlined,
                  title: 'Mengandung kata kasar',
                  message: 'Kata yang tidak pantas sudah disamarkan otomatis. Pertimbangkan sebelum menampilkan di papan.',
                  tone: palette.danger,
                ),
              ],
              const SizedBox(height: Gaps.xl),
              const SectionHeader(title: 'Pengirim'),
              const SizedBox(height: Gaps.md),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: palette.neutral.container,
                    child: Icon(
                      aspiration.fromGuest ? Icons.public_rounded : (aspiration.anonymous ? Icons.visibility_off_outlined : Icons.person_outline_rounded),
                      color: palette.neutral.main,
                    ),
                  ),
                  title: Text(sender.$1),
                  subtitle: Text(sender.$2),
                ),
              ),
              if (aspiration.response != null) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Tanggapan resmi'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Gaps.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(aspiration.response!.message),
                        const SizedBox(height: Gaps.sm),
                        Text(
                          [
                            aspiration.response!.respondedByName,
                            if (aspiration.response!.respondedAt != null) formatDateTime(aspiration.response!.respondedAt!),
                          ].join(' · '),
                          style: muted,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewSheet extends ConsumerStatefulWidget {
  const _ReviewSheet({required this.aspiration, required this.boardEnabled});

  final Aspiration aspiration;
  final bool boardEnabled;

  @override
  ConsumerState<_ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends ConsumerState<_ReviewSheet> with ActionSheetState {
  late final _response = TextEditingController(text: widget.aspiration.response?.message ?? '');
  late AspirationStatus _status =
      widget.aspiration.status == AspirationStatus.diterima ? AspirationStatus.ditinjau : widget.aspiration.status;
  late BoardState _board = widget.aspiration.board;

  @override
  void dispose() {
    _response.dispose();
    super.dispose();
  }

  void _send() {
    final aspiration = widget.aspiration;
    final response = _response.text.trim();
    final responseChanged = response.isNotEmpty && response != (aspiration.response?.message ?? '');
    final statusChanged = _status != aspiration.status;
    final boardChanged = _board != aspiration.board;
    if (response.isNotEmpty && response.length < 5) return fail('Tanggapan minimal 5 karakter.');
    if (!responseChanged && !statusChanged && !boardChanged) return fail('Belum ada perubahan untuk disimpan.');
    submit(
      () => ref.read(aspirationRepositoryProvider).review(
            schoolId: aspiration.schoolId,
            aspirationId: aspiration.id,
            status: statusChanged ? _status : null,
            response: responseChanged ? response : null,
            board: boardChanged ? _board : null,
          ),
      successMessage: 'Tanggapan disimpan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final fromMember = !widget.aspiration.fromGuest;
    return ActionSheet(
      title: 'Tanggapi aspirasi',
      description: fromMember
          ? 'Pengirim mendapat notifikasi saat status atau tanggapan berubah.'
          : 'Aspirasi tamu tidak dapat dilacak pengirimnya; tanggapan tetap tampil bila aspirasi dipasang di papan.',
      submitLabel: 'Simpan',
      busy: busy,
      error: error,
      onSubmit: _send,
      children: [
        Text('Status', style: context.textStyles.titleSmall),
        const SizedBox(height: Gaps.sm),
        Wrap(
          spacing: Gaps.sm,
          runSpacing: Gaps.sm,
          children: [
            for (final status in AspirationStatus.values)
              ChoiceChip(
                label: Text(status.label),
                selected: _status == status,
                onSelected: busy ? null : (_) => setState(() => _status = status),
              ),
          ],
        ),
        const SizedBox(height: Gaps.lg),
        TextField(
          controller: _response,
          enabled: !busy,
          minLines: 3,
          maxLines: 8,
          maxLength: 2000,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Tanggapan resmi sekolah',
            hintText: 'Contoh: Terima kasih. Usulan ini akan dibahas bersama OSIS pada rapat bulan depan.',
            alignLabelWithHint: true,
          ),
        ),
        if (widget.boardEnabled) ...[
          const SizedBox(height: Gaps.sm),
          Text('Papan aspirasi', style: context.textStyles.titleSmall),
          const SizedBox(height: Gaps.sm),
          SegmentedButton<BoardState>(
            segments: const [
              ButtonSegment(value: BoardState.none, label: Text('Belum')),
              ButtonSegment(value: BoardState.published, label: Text('Tampilkan')),
              ButtonSegment(value: BoardState.hidden, label: Text('Sembunyikan')),
            ],
            selected: {_board},
            onSelectionChanged: busy ? null : (selection) => setState(() => _board = selection.first),
          ),
          const SizedBox(height: Gaps.xs),
          Text(
            'Papan hanya terlihat oleh siswa sekolah ini, tanpa nama pengirim.',
            style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}
