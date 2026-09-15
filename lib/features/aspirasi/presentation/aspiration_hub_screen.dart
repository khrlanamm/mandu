import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../../schools/data/school_repository.dart';
import '../data/aspiration_repository.dart';
import '../domain/aspiration.dart';
import 'widgets/aspiration_widgets.dart';

/// Aspirasi siswa: papan aspirasi sekolah dan aspirasi yang pernah dikirim.
class AspirationHubScreen extends ConsumerWidget {
  const AspirationHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    if (schoolId == null) return const Scaffold(body: LoadingView());
    final showBoard = ref.watch(schoolDocProvider(schoolId)).value?.aspirationBoard ?? true;

    return DefaultTabController(
      length: showBoard ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aspirasi'),
          bottom: TabBar(
            tabs: [
              if (showBoard) const Tab(text: 'Papan aspirasi'),
              const Tab(text: 'Aspirasiku'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(Routes.studentAspirationForm),
          icon: const Icon(Icons.lightbulb_rounded),
          label: const Text('Kirim aspirasi'),
        ),
        body: TabBarView(
          children: [
            if (showBoard) _BoardTab(schoolId: schoolId),
            const _MineTab(),
          ],
        ),
      ),
    );
  }
}

class _BoardTab extends ConsumerStatefulWidget {
  const _BoardTab({required this.schoolId});

  final String schoolId;

  @override
  ConsumerState<_BoardTab> createState() => _BoardTabState();
}

class _BoardTabState extends ConsumerState<_BoardTab> {
  BoardSort _sort = BoardSort.popular;

  @override
  Widget build(BuildContext context) {
    final board = ref.watch(aspirationBoardProvider(widget.schoolId, _sort));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.sm),
          child: ContentWidth(
            child: SegmentedButton<BoardSort>(
              segments: const [
                ButtonSegment(value: BoardSort.popular, label: Text('Paling didukung'), icon: Icon(Icons.trending_up_rounded)),
                ButtonSegment(value: BoardSort.newest, label: Text('Terbaru'), icon: Icon(Icons.schedule_rounded)),
              ],
              selected: {_sort},
              onSelectionChanged: (selection) => setState(() => _sort = selection.first),
            ),
          ),
        ),
        Expanded(
          child: AsyncValueView(
            value: board,
            onRetry: () => ref.invalidate(aspirationBoardProvider(widget.schoolId, _sort)),
            data: (items) => items.isEmpty
                ? EmptyState(
                    icon: Icons.push_pin_outlined,
                    tone: context.palette.aspirasi,
                    title: 'Papan masih kosong',
                    message: 'Aspirasi yang disetujui sekolah akan tampil di sini beserta tanggapannya.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.xs, Gaps.lg, 96),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
                    itemBuilder: (context, index) => ContentWidth(
                      child: AspirationCard(
                        aspiration: items[index],
                        onTap: () => context.push(Routes.studentAspiration(items[index].id)),
                        footer: Align(alignment: Alignment.centerLeft, child: SupportButton(aspiration: items[index])),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _MineTab extends ConsumerWidget {
  const _MineTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueView(
      value: ref.watch(myAspirationsProvider),
      onRetry: () => ref.invalidate(myAspirationsProvider),
      data: (owners) => owners.isEmpty
          ? EmptyState(
              icon: Icons.lightbulb_outline_rounded,
              tone: context.palette.aspirasi,
              title: 'Belum ada aspirasi',
              message: 'Punya saran, ide, atau kritik untuk sekolah? Kirimkan dan pantau tanggapannya di sini.',
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, 96),
              itemCount: owners.length,
              separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
              itemBuilder: (context, index) => ContentWidth(child: _OwnedAspirationTile(owner: owners[index])),
            ),
    );
  }
}

class _OwnedAspirationTile extends ConsumerWidget {
  const _OwnedAspirationTile({required this.owner});

  final AspirationOwner owner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId ?? '';
    final aspiration = ref.watch(aspirationProvider(schoolId, owner.id)).value;
    if (aspiration == null) {
      return const Card(child: SizedBox(height: 120, child: Center(child: CircularProgressIndicator(strokeWidth: 2))));
    }
    return AspirationCard(aspiration: aspiration, onTap: () => context.push(Routes.studentAspiration(aspiration.id)));
  }
}
