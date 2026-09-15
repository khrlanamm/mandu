import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/design/palette.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/design/widgets/feedback.dart';
import '../../../../core/design/widgets/layout.dart';
import '../../../auth/application/session_controller.dart';
import '../../data/article_repository.dart';
import '../../domain/article.dart';

String? scholarshipDeadlineLabel(Scholarship scholarship) {
  final date = scholarship.deadlineDate;
  if (date == null) return null;
  final days = date.difference(DateTime.now()).inDays;
  final formatted = DateFormat('d MMMM yyyy', 'id_ID').format(date);
  if (days < 0) return 'Tenggat lewat ($formatted)';
  if (days == 0) return 'Tenggat hari ini';
  return 'Tenggat $formatted · $days hari lagi';
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article, required this.onTap, this.trailing});

  final Article article;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    final scholarship = article.scholarship;

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
                  Icon(article.type.icon, size: 18, color: palette.edukasi.main),
                  const SizedBox(width: Gaps.xs),
                  Expanded(
                    child: Text(
                      article.categoryLabel.isEmpty ? (kArticleCategories[article.category] ?? '') : article.categoryLabel,
                      style: context.textStyles.labelMedium?.copyWith(color: palette.edukasi.onContainer),
                    ),
                  ),
                  if (article.featured) StatusPill(label: 'Unggulan', tone: palette.aspirasi, icon: Icons.star_rounded),
                  ?trailing,
                ],
              ),
              const SizedBox(height: Gaps.sm),
              Text(article.title, style: context.textStyles.titleSmall),
              const SizedBox(height: 2),
              Text(article.summary, maxLines: 3, overflow: TextOverflow.ellipsis, style: context.textStyles.bodyMedium),
              const SizedBox(height: Gaps.sm),
              Wrap(
                spacing: Gaps.sm,
                runSpacing: Gaps.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  StatusPill(
                    label: article.isGlobal ? 'MANDU' : 'Sekolah',
                    tone: article.isGlobal ? palette.info : palette.success,
                    icon: article.isGlobal ? Icons.verified_rounded : Icons.apartment_rounded,
                  ),
                  if (!article.published) StatusPill(label: 'Draf', tone: palette.neutral, icon: Icons.edit_note_rounded),
                  if (scholarship != null && scholarshipDeadlineLabel(scholarship) != null)
                    StatusPill(
                      label: scholarshipDeadlineLabel(scholarship)!,
                      tone: scholarship.isExpired ? palette.neutral : palette.warning,
                      icon: Icons.event_outlined,
                    ),
                  if (article.views > 0) Text('${article.views}x dibaca', style: muted),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tombol simpan artikel ke daftar tersimpan pengguna.
class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(currentAccountProvider)?.uid;
    final saved = ref.watch(bookmarksProvider).value?.any((bookmark) => bookmark.id == article.bookmarkId) ?? false;
    return IconButton(
      tooltip: saved ? 'Hapus dari tersimpan' : 'Simpan artikel',
      onPressed: uid == null
          ? null
          : () => runGuarded(
                context,
                () => ref.read(articleRepositoryProvider).toggleBookmark(uid: uid, article: article, save: !saved),
                successMessage: saved ? 'Dihapus dari tersimpan.' : 'Artikel disimpan.',
              ),
      icon: Icon(saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded),
    );
  }
}
