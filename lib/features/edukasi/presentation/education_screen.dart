import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../data/article_repository.dart';
import '../domain/article.dart';
import 'widgets/article_widgets.dart';

/// Edukasi: bacaan dan info beasiswa dari MANDU serta sekolah.
class EducationScreen extends ConsumerStatefulWidget {
  const EducationScreen({super.key});

  @override
  ConsumerState<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends ConsumerState<EducationScreen> {
  final _search = TextEditingController();
  String? _category;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(Article article) {
    final keyword = _search.text.trim().toLowerCase();
    final byKeyword = keyword.isEmpty ||
        article.title.toLowerCase().contains(keyword) ||
        article.summary.toLowerCase().contains(keyword);
    return byKeyword && (_category == null || article.category == _category);
  }

  @override
  Widget build(BuildContext context) {
    final feed = ref.watch(educationFeedProvider);
    final loading = ref.watch(globalArticlesProvider()).isLoading;
    final scholarships = feed.where((article) => article.type == ArticleType.beasiswa).toList()
      ..sort((a, b) => (a.scholarship?.deadline ?? '') .compareTo(b.scholarship?.deadline ?? ''));
    final readings = feed.where((article) => article.type != ArticleType.beasiswa).where(_matches).toList();
    final categories = {for (final article in readings) article.category};

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edukasi'),
          actions: [
            IconButton(
              tooltip: 'Tersimpan',
              onPressed: () => context.push(Routes.studentBookmarks),
              icon: const Icon(Icons.bookmark_border_rounded),
            ),
          ],
          bottom: const TabBar(tabs: [Tab(text: 'Bacaan'), Tab(text: 'Beasiswa')]),
        ),
        body: TabBarView(
          children: [
            _Readings(
              articles: readings,
              loading: loading,
              search: _search,
              category: _category,
              categories: categories,
              onSearch: () => setState(() {}),
              onCategory: (value) => setState(() => _category = value),
            ),
            _Scholarships(articles: scholarships, loading: loading),
          ],
        ),
      ),
    );
  }
}

class _Readings extends StatelessWidget {
  const _Readings({
    required this.articles,
    required this.loading,
    required this.search,
    required this.category,
    required this.categories,
    required this.onSearch,
    required this.onCategory,
  });

  final List<Article> articles;
  final bool loading;
  final TextEditingController search;
  final String? category;
  final Set<String> categories;
  final VoidCallback onSearch;
  final ValueChanged<String?> onCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.sm),
          child: ContentWidth(
            child: TextField(
              controller: search,
              onChanged: (_) => onSearch(),
              decoration: InputDecoration(
                hintText: 'Cari bacaan...',
                prefixIcon: const Icon(Icons.search_rounded),
                isDense: true,
                suffixIcon: search.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Bersihkan',
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          search.clear();
                          onSearch();
                        },
                      ),
              ),
            ),
          ),
        ),
        if (categories.isNotEmpty)
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.xs),
              children: [
                ChoiceChip(label: const Text('Semua'), selected: category == null, onSelected: (_) => onCategory(null)),
                const SizedBox(width: Gaps.sm),
                for (final key in categories) ...[
                  ChoiceChip(
                    label: Text(kArticleCategories[key] ?? key),
                    selected: category == key,
                    onSelected: (_) => onCategory(key),
                  ),
                  const SizedBox(width: Gaps.sm),
                ],
              ],
            ),
          ),
        Expanded(
          child: articles.isEmpty
              ? (loading
                  ? const LoadingView()
                  : EmptyState(
                      icon: Icons.menu_book_rounded,
                      tone: context.palette.edukasi,
                      title: 'Belum ada bacaan',
                      message: 'Artikel dari MANDU dan sekolahmu akan tampil di sini.',
                    ))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxl),
                  itemCount: articles.length,
                  separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
                  itemBuilder: (context, index) => ContentWidth(
                    child: ArticleCard(
                      article: articles[index],
                      onTap: () => context.push(
                        Routes.studentArticleById(articles[index].id, schoolId: articles[index].schoolId),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _Scholarships extends StatelessWidget {
  const _Scholarships({required this.articles, required this.loading});

  final List<Article> articles;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return loading
          ? const LoadingView()
          : EmptyState(
              icon: Icons.school_outlined,
              tone: context.palette.edukasi,
              title: 'Belum ada info beasiswa',
              message: 'Informasi beasiswa beserta tenggat pendaftarannya akan tampil di sini.',
            );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
      itemCount: articles.length,
      separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
      itemBuilder: (context, index) => ContentWidth(
        child: ArticleCard(
          article: articles[index],
          onTap: () => context.push(
            Routes.studentArticleById(articles[index].id, schoolId: articles[index].schoolId),
          ),
        ),
      ),
    );
  }
}
