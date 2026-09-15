import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/ui_helpers.dart';
import '../../data/models/article.dart';
import '../../data/repositories/article_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../services/notification_service.dart';
import '../article/article_webview_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import '../report/report_screen.dart';
import 'widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _loadErrorMessage = 'Gagal memuat artikel. Periksa koneksi internet Anda.';

  final _searchController = TextEditingController();

  List<Article> _articles = const [];
  bool _isLoading = true;
  String? _errorMessage;
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _loadArticles();

    final uid = AuthRepository.instance.currentUser?.uid;
    if (uid != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => NotificationService.instance.onUserSignedIn(uid),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    setState(() => _isLoading = true);
    try {
      final articles = await ArticleRepository.instance.fetchArticles();
      if (!mounted) return;
      setState(() {
        _articles = articles;
        _errorMessage = null;
      });
    } catch (e) {
      debugPrint('Gagal memuat artikel: $e');
      if (!mounted) return;
      setState(() {
        _articles = const [];
        _errorMessage = _loadErrorMessage;
      });
      showSnack(context, _loadErrorMessage);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<Article> get _filteredArticles {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _articles;
    return _articles.where((article) => article.title.toLowerCase().contains(query)).toList();
  }

  void _push(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  void _openArticle(Article article) {
    if (article.hasSecureUrl) {
      _push(ArticleWebViewScreen(url: article.url));
    } else {
      showSnack(context, 'Tautan artikel tidak valid.');
    }
  }

  void _onBackPressed(bool didPop, Object? result) {
    if (didPop) return;
    final now = DateTime.now();
    final lastPressed = _lastBackPressed;
    if (lastPressed != null && now.difference(lastPressed) < const Duration(seconds: 2)) {
      SystemNavigator.pop();
    } else {
      _lastBackPressed = now;
      showSnack(context, 'Tekan sekali lagi untuk keluar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filteredArticles;
    final hasQuery = _searchController.text.trim().isNotEmpty;

    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 16,
          title: Row(
            children: [
              Image.asset(AppAssets.appLogo, width: 32, height: 32),
              const SizedBox(width: 8),
              const Text(
                'Teman Ngadu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Riwayat Laporan',
              onPressed: () => _push(const HistoryScreen()),
              icon: SvgPicture.asset(AppAssets.icHistory, width: 26, height: 26),
            ),
            IconButton(
              tooltip: 'Akun',
              onPressed: () => _push(const ProfileScreen()),
              icon: SvgPicture.asset(AppAssets.icAccount, width: 26, height: 26),
            ),
            const SizedBox(width: 8),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Tambahkan Laporan',
          onPressed: () => _push(const ReportScreen()),
          child: SvgPicture.asset(AppAssets.icReport, width: 30, height: 30),
        ),
        body: RefreshIndicator(
          onRefresh: _loadArticles,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                sliver: SliverList.list(
                  children: [
                    _ReportBanner(onTap: () => _push(const ReportScreen())),
                    const SizedBox(height: 12),
                    const Text(
                      'Edukasi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ayo baca artikel terkait Bullying',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                    _SearchField(controller: _searchController),
                  ],
                ),
              ),
              if (_isLoading && _articles.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (articles.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      hasQuery
                          ? 'Artikel yang anda cari belum tersedia'
                          : _errorMessage ?? 'Belum ada artikel.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    96 + MediaQuery.paddingOf(context).bottom,
                  ),
                  sliver: SliverList.separated(
                    itemCount: articles.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => ArticleCard(
                      article: articles[index],
                      onTap: () => _openArticle(articles[index]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportBanner extends StatelessWidget {
  const _ReportBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Image.asset(AppAssets.homeBanner, fit: BoxFit.cover)),
          const SizedBox(width: 4),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.tosca,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppAssets.reportIllustration),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Laporkan Bullying',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.toscaDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Cari Artikel…',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Hapus pencarian',
                  onPressed: controller.clear,
                  icon: const Icon(Icons.clear),
                ),
          filled: false,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
