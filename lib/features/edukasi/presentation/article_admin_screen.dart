import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../data/article_repository.dart';
import '../domain/article.dart';
import 'widgets/article_widgets.dart';

/// Kelola konten Edukasi: global (superadmin) atau milik sekolah (admin & konselor).
class ArticleAdminScreen extends ConsumerWidget {
  const ArticleAdminScreen({super.key, required this.global});

  final bool global;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    if (!global && schoolId == null) return const Scaffold(body: LoadingView());
    final articles = global
        ? ref.watch(globalArticlesProvider(editorMode: true))
        : ref.watch(schoolArticlesProvider(schoolId!, editorMode: true));

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(global ? Routes.superadminHome : Routes.staffHome),
              ),
        title: Text(global ? 'Edukasi MANDU' : 'Edukasi sekolah'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(global ? Routes.superadminArticleNew : Routes.staffArticleNew),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tulis konten'),
      ),
      body: AsyncValueView(
        value: articles,
        onRetry: () => ref.invalidate(global ? globalArticlesProvider(editorMode: true) : schoolArticlesProvider(schoolId!, editorMode: true)),
        data: (items) => items.isEmpty
            ? EmptyState(
                icon: Icons.menu_book_rounded,
                tone: context.palette.edukasi,
                title: 'Belum ada konten',
                message: global
                    ? 'Tulis artikel, tautan, atau info beasiswa yang akan dibaca semua sekolah.'
                    : 'Tulis pengumuman, panduan, atau info beasiswa khusus untuk siswa sekolahmu.',
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, 96),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
                itemBuilder: (context, index) => ContentWidth(
                  child: ArticleCard(
                    article: items[index],
                    trailing: const Icon(Icons.edit_outlined, size: 18),
                    onTap: () => context.push(
                      global
                          ? Routes.superadminArticleEdit(items[index].id)
                          : Routes.staffArticleEdit(items[index].id),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

/// Artikel yang sedang diedit (null untuk konten baru).
final editingArticleProvider = Provider.family<Article?, ({String id, String? schoolId})>((ref, key) {
  return ref.watch(articleProvider(key.id, schoolId: key.schoolId)).value;
});
