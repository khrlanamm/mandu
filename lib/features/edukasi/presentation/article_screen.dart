import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../lapor/presentation/widgets/ticket_widgets.dart';
import '../data/article_repository.dart';
import '../domain/article.dart';
import 'widgets/article_widgets.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  const ArticleScreen({super.key, required this.articleId, this.schoolId});

  final String articleId;
  final String? schoolId;

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(articleRepositoryProvider)
          .markRead(articleId: widget.articleId, schoolId: widget.schoolId)
          .catchError((Object _) {});
    });
  }

  Future<void> _open(String url) async {
    final opened = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!opened && mounted) showSnack(context, 'Tautan tidak dapat dibuka.', error: true);
  }

  @override
  Widget build(BuildContext context) {
    final articleAsync = ref.watch(articleProvider(widget.articleId, schoolId: widget.schoolId));
    final article = articleAsync.value;
    final palette = context.palette;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(Routes.studentEducation),
              ),
        title: const Text('Edukasi'),
        actions: [if (article != null) BookmarkButton(article: article)],
      ),
      body: AsyncValueView(
        value: articleAsync,
        onRetry: () => ref.invalidate(articleProvider(widget.articleId, schoolId: widget.schoolId)),
        data: (article) {
          if (article == null) {
            return const EmptyState(icon: Icons.search_off_rounded, title: 'Artikel tidak ditemukan');
          }
          final scholarship = article.scholarship;
          return ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (article.coverUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Radii.lg),
                        child: Image.network(
                          article.coverUrl!,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                    const SizedBox(height: Gaps.md),
                    Wrap(
                      spacing: Gaps.sm,
                      runSpacing: Gaps.xs,
                      children: [
                        StatusPill(label: article.categoryLabel, tone: palette.edukasi, icon: article.type.icon),
                        StatusPill(
                          label: article.isGlobal ? 'MANDU' : 'Sekolah',
                          tone: article.isGlobal ? palette.info : palette.success,
                        ),
                      ],
                    ),
                    const SizedBox(height: Gaps.sm),
                    Text(article.title, style: context.textStyles.headlineSmall),
                    const SizedBox(height: Gaps.xs),
                    Text(
                      [
                        article.authorName,
                        if (article.publishedAt != null) formatDateTime(article.publishedAt!),
                      ].where((part) => part.isNotEmpty).join(' · '),
                      style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: Gaps.lg),
                    Text(article.summary, style: context.textStyles.bodyLarge),
                    const SizedBox(height: Gaps.lg),
                    if (scholarship != null) ...[
                      Card(
                        color: palette.edukasi.container,
                        child: Padding(
                          padding: const EdgeInsets.all(Gaps.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailRow(icon: Icons.apartment_rounded, label: 'Penyelenggara', value: scholarship.organizer),
                              DetailRow(icon: Icons.school_outlined, label: 'Jenjang', value: scholarship.level),
                              DetailRow(
                                icon: Icons.event_outlined,
                                label: 'Tenggat',
                                value: scholarshipDeadlineLabel(scholarship) ?? scholarship.deadline,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Gaps.lg),
                    ],
                    if (article.body.isNotEmpty) MarkdownBody(data: article.body, selectable: true),
                    if (article.url != null) ...[
                      const SizedBox(height: Gaps.lg),
                      FilledButton.icon(
                        onPressed: () => _open(article.url!),
                        icon: const Icon(Icons.open_in_new_rounded),
                        label: Text(article.type == ArticleType.beasiswa ? 'Buka info pendaftaran' : 'Buka tautan'),
                      ),
                      const SizedBox(height: Gaps.xs),
                      Text(
                        'Tautan akan dibuka di peramban. Periksa kembali alamatnya sebelum mengisi data pribadi.',
                        style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Daftar artikel yang disimpan pengguna.
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Tersimpan')),
      body: AsyncValueView(
        value: bookmarks,
        onRetry: () => ref.invalidate(bookmarksProvider),
        data: (items) => items.isEmpty
            ? EmptyState(
                icon: Icons.bookmark_border_rounded,
                tone: context.palette.edukasi,
                title: 'Belum ada yang disimpan',
                message: 'Ketuk ikon simpan pada artikel untuk membacanya lagi nanti.',
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: Gaps.sm),
                itemBuilder: (context, index) {
                  final bookmark = items[index];
                  return ContentWidth(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        leading: Icon(Icons.bookmark_rounded, color: context.palette.edukasi.main),
                        title: Text(bookmark.title),
                        subtitle: Text(bookmark.scope == 'global' ? 'Artikel MANDU' : 'Artikel sekolah'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => context.push(
                          Routes.studentArticleById(
                            bookmark.id.split('__').last,
                            schoolId: bookmark.scope == 'global' ? null : bookmark.schoolId,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
