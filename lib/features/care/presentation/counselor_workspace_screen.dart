import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../data/care_repository.dart';
import '../domain/care.dart';
import 'widgets/care_widgets.dart';

/// Ruang kerja konselor: antrean Butuh Bantuan dan percakapan Curhat.
class CounselorWorkspaceScreen extends StatelessWidget {
  const CounselorWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: context.canPop()
              ? null
              : IconButton(
                  tooltip: 'Tutup',
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => context.go(Routes.staffHome),
                ),
          title: const Text('Ruang konselor'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Butuh Bantuan'), Tab(text: 'Curhat')],
          ),
        ),
        body: const TabBarView(children: [_HelpQueueTab(), _CurhatTab()]),
      ),
    );
  }
}

class _HelpQueueTab extends ConsumerStatefulWidget {
  const _HelpQueueTab();

  @override
  ConsumerState<_HelpQueueTab> createState() => _HelpQueueTabState();
}

class _HelpQueueTabState extends ConsumerState<_HelpQueueTab> {
  HelpStatus? _status = HelpStatus.menunggu;

  @override
  Widget build(BuildContext context) {
    return AsyncValueView(
      value: ref.watch(helpQueueProvider),
      onRetry: () => ref.invalidate(helpQueueProvider),
      data: (all) {
        final visible = _status == null ? all : all.where((request) => request.status == _status).toList();
        return Column(
          children: [
            SizedBox(
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.sm),
                children: [
                  for (final status in [...HelpStatus.values, null]) ...[
                    ChoiceChip(
                      label: Text(
                        '${status?.label ?? 'Semua'} (${status == null ? all.length : all.where((r) => r.status == status).length})',
                      ),
                      selected: _status == status,
                      onSelected: (_) => setState(() => _status = status),
                    ),
                    const SizedBox(width: Gaps.sm),
                  ],
                ],
              ),
            ),
            Expanded(
              child: visible.isEmpty
                  ? EmptyState(
                      icon: Icons.volunteer_activism_outlined,
                      tone: context.palette.bantuan,
                      title: 'Tidak ada permintaan',
                      message: 'Permintaan bantuan siswa akan muncul di sini beserta notifikasinya.',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.xs, Gaps.lg, Gaps.xxl),
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
                      itemBuilder: (context, index) => ContentWidth(
                        child: HelpRequestCard(
                          request: visible[index],
                          staffView: true,
                          onTap: () => context.push(Routes.staffHelpDetail(visible[index].id)),
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _CurhatTab extends ConsumerWidget {
  const _CurhatTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waiting = ref.watch(waitingConversationsProvider).value ?? const [];
    final mine = ref.watch(counselorConversationsProvider);

    return AsyncValueView(
      value: mine,
      onRetry: () => ref.invalidate(counselorConversationsProvider),
      data: (conversations) {
        final active = conversations.where((conversation) => conversation.isOpen).toList();
        final closed = conversations.where((conversation) => !conversation.isOpen).toList();
        if (waiting.isEmpty && conversations.isEmpty) {
          return EmptyState(
            icon: Icons.forum_outlined,
            tone: context.palette.curhat,
            title: 'Belum ada percakapan',
            message: 'Curhat dari siswa akan muncul di sini. Kamu akan mendapat notifikasi saat ada yang ingin bercerita.',
          );
        }
        return ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (waiting.isNotEmpty) ...[
                    SectionHeader(title: 'Menunggu konselor (${waiting.length})'),
                    const SizedBox(height: Gaps.md),
                    for (final conversation in waiting) ...[
                      ConversationTile(
                        conversation: conversation,
                        asCounselor: true,
                        onTap: () => context.push(Routes.staffConversation(conversation.id)),
                      ),
                      const SizedBox(height: Gaps.md),
                    ],
                    const SizedBox(height: Gaps.lg),
                  ],
                  if (active.isNotEmpty) ...[
                    SectionHeader(title: 'Percakapan saya (${active.length})'),
                    const SizedBox(height: Gaps.md),
                    for (final conversation in active) ...[
                      ConversationTile(
                        conversation: conversation,
                        asCounselor: true,
                        onTap: () => context.push(Routes.staffConversation(conversation.id)),
                      ),
                      const SizedBox(height: Gaps.md),
                    ],
                  ],
                  if (closed.isNotEmpty) ...[
                    const SizedBox(height: Gaps.lg),
                    const SectionHeader(title: 'Sudah ditutup'),
                    const SizedBox(height: Gaps.md),
                    for (final conversation in closed) ...[
                      ConversationTile(
                        conversation: conversation,
                        asCounselor: true,
                        onTap: () => context.push(Routes.staffConversation(conversation.id)),
                      ),
                      const SizedBox(height: Gaps.md),
                    ],
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
