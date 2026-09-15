import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../data/care_repository.dart';
import 'widgets/care_widgets.dart';

/// Daftar percakapan Curhat milik siswa.
class CurhatListScreen extends ConsumerWidget {
  const CurhatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(myConversationsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Curhat')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.studentCurhatStart),
        icon: const Icon(Icons.forum_rounded),
        label: const Text('Mulai curhat'),
      ),
      body: AsyncValueView(
        value: conversations,
        onRetry: () => ref.invalidate(myConversationsProvider),
        data: (items) => ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, 96),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: context.palette.curhat.container,
                    child: Padding(
                      padding: const EdgeInsets.all(Gaps.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cerita apa pun, tetap rahasia',
                            style: context.textStyles.titleSmall?.copyWith(color: context.palette.curhat.onContainer),
                          ),
                          const SizedBox(height: Gaps.xs),
                          Text(
                            'Hanya kamu dan guru BK yang membaca percakapan ini. Kamu boleh memakai nama samaran.',
                            style: context.textStyles.bodySmall?.copyWith(color: context.palette.curhat.onContainer),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Gaps.lg),
                  if (items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: Gaps.xxl),
                      child: EmptyState(
                        icon: Icons.forum_outlined,
                        tone: context.palette.curhat,
                        title: 'Belum ada percakapan',
                        message: 'Ketuk "Mulai curhat" untuk bercerita kepada guru BK.',
                      ),
                    )
                  else
                    for (final conversation in items) ...[
                      ConversationTile(
                        conversation: conversation,
                        asCounselor: false,
                        onTap: () => context.push(Routes.studentConversation(conversation.id)),
                      ),
                      const SizedBox(height: Gaps.md),
                    ],
                  const SizedBox(height: Gaps.lg),
                  const EmergencyContactsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
