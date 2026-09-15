import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../../lapor/presentation/widgets/ticket_widgets.dart';
import '../data/aspiration_repository.dart';
import '../domain/aspiration.dart';
import 'widgets/aspiration_widgets.dart';

class StudentAspirationScreen extends ConsumerWidget {
  const StudentAspirationScreen({super.key, required this.aspirationId, this.justSubmitted = false});

  final String aspirationId;
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
                onPressed: () => context.go(Routes.studentAspirations),
              ),
        title: const Text('Aspirasi'),
      ),
      body: schoolId == null
          ? const LoadingView()
          : AsyncValueView(
              value: ref.watch(aspirationProvider(schoolId, aspirationId)),
              onRetry: () => ref.invalidate(aspirationProvider(schoolId, aspirationId)),
              data: (aspiration) => aspiration == null
                  ? const EmptyState(icon: Icons.search_off_rounded, title: 'Aspirasi tidak ditemukan')
                  : _Body(aspiration: aspiration, justSubmitted: justSubmitted),
            ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.aspiration, required this.justSubmitted});

  final Aspiration aspiration;
  final bool justSubmitted;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    final response = aspiration.response;

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
                  title: 'Aspirasi terkirim',
                  message: 'Nomor ${aspiration.number}. Kamu akan mendapat notifikasi saat sekolah menanggapi.',
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
                          Expanded(child: Text(aspiration.number, style: context.textStyles.labelMedium)),
                          AspirationStatusPill(status: aspiration.status),
                        ],
                      ),
                      const SizedBox(height: Gaps.sm),
                      Text(aspiration.title, style: context.textStyles.titleLarge),
                      Text('${aspiration.type.label} · ${aspiration.topicLabel}', style: muted),
                      const SizedBox(height: Gaps.md),
                      Text(aspiration.content, style: context.textStyles.bodyMedium),
                      const SizedBox(height: Gaps.md),
                      if (aspiration.createdAt != null)
                        DetailRow(icon: Icons.send_outlined, label: 'Dikirim', value: formatDateTime(aspiration.createdAt!)),
                      DetailRow(
                        icon: aspiration.anonymous ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        label: 'Identitas',
                        value: aspiration.anonymous
                            ? 'Dirahasiakan dari admin sekolah'
                            : 'Terlihat oleh admin sekolah, tidak tampil di papan',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Gaps.lg),
              InfoBanner(icon: aspiration.status.icon, message: aspiration.status.description, tone: aspiration.status.tone(palette)),
              if (response != null) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Tanggapan sekolah'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Gaps.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(response.message, style: context.textStyles.bodyMedium),
                        const SizedBox(height: Gaps.sm),
                        Text(
                          [response.respondedByName, if (response.respondedAt != null) formatDateTime(response.respondedAt!)].join(' · '),
                          style: muted,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (aspiration.board == BoardState.published) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Papan aspirasi'),
                const SizedBox(height: Gaps.sm),
                Text('Aspirasi ini tampil di papan aspirasi sekolah. Siswa lain dapat memberi dukungan.', style: muted),
                const SizedBox(height: Gaps.md),
                Align(alignment: Alignment.centerLeft, child: SupportButton(aspiration: aspiration)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
