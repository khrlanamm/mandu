import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/errors.dart';
import '../../auth/application/session_controller.dart';
import '../data/article_repository.dart';
import '../domain/article.dart';

/// Editor konten Edukasi untuk superadmin (global) dan admin/konselor (sekolah).
class ArticleEditorScreen extends ConsumerStatefulWidget {
  const ArticleEditorScreen({super.key, required this.global, this.articleId});

  final bool global;
  final String? articleId;

  @override
  ConsumerState<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends ConsumerState<ArticleEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _summary = TextEditingController();
  final _body = TextEditingController();
  final _url = TextEditingController();
  final _cover = TextEditingController();
  final _organizer = TextEditingController();
  final _level = TextEditingController();
  final _deadline = TextEditingController();
  final _scholarshipUrl = TextEditingController();

  String _category = kArticleCategories.keys.first;
  ArticleType _type = ArticleType.artikel;
  bool _featured = false;
  bool _published = true;
  bool _busy = false;
  bool _loaded = false;

  @override
  void dispose() {
    for (final controller in [_title, _summary, _body, _url, _cover, _organizer, _level, _deadline, _scholarshipUrl]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _fill(Article article) {
    if (_loaded) return;
    _loaded = true;
    _title.text = article.title;
    _summary.text = article.summary;
    _body.text = article.body;
    _url.text = article.url ?? '';
    _cover.text = article.coverUrl ?? '';
    _category = article.category;
    _type = article.type;
    _featured = article.featured;
    _published = article.published;
    final scholarship = article.scholarship;
    if (scholarship != null) {
      _organizer.text = scholarship.organizer;
      _level.text = scholarship.level;
      _deadline.text = scholarship.deadline;
      _scholarshipUrl.text = scholarship.url;
    }
  }

  Future<void> _save(String? schoolId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await ref.read(articleRepositoryProvider).save(
            ArticleDraft(
              articleId: widget.articleId,
              schoolId: schoolId,
              title: _title.text,
              category: _category,
              type: _type,
              summary: _summary.text,
              body: _body.text,
              url: _url.text,
              coverUrl: _cover.text,
              scholarship: _type == ArticleType.beasiswa
                  ? Scholarship(
                      organizer: _organizer.text,
                      level: _level.text,
                      deadline: _deadline.text,
                      url: _scholarshipUrl.text,
                    )
                  : null,
              featured: _featured,
              published: _published,
            ),
          );
      if (mounted) {
        showSnack(context, 'Konten disimpan.');
        context.pop();
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      showSnack(context, describeError(error), error: true);
    }
  }

  Future<void> _delete(String? schoolId) async {
    final confirmed = await confirmAction(
      context,
      title: 'Hapus konten?',
      message: 'Konten ini akan hilang dari Edukasi dan tidak bisa dikembalikan.',
      confirmLabel: 'Hapus',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    final ok = await runGuarded(context, () async {
      await ref.read(articleRepositoryProvider).delete(articleId: widget.articleId!, schoolId: schoolId);
      return true;
    }, successMessage: 'Konten dihapus.');
    if (ok == true && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final schoolId = widget.global ? null : ref.watch(currentAccountProvider)?.schoolId;
    if (!widget.global && schoolId == null) return const Scaffold(body: LoadingView());
    if (widget.articleId != null) {
      final existing = ref.watch(articleProvider(widget.articleId!, schoolId: schoolId)).value;
      if (existing == null) {
        return Scaffold(appBar: AppBar(), body: const LoadingView());
      }
      _fill(existing);
    }
    final isScholarship = _type == ArticleType.beasiswa;
    final isLink = _type == ArticleType.tautan;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleId == null ? 'Tulis konten' : 'Ubah konten'),
        actions: [
          if (widget.articleId != null)
            IconButton(
              tooltip: 'Hapus',
              onPressed: _busy ? null : () => _delete(schoolId),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Gaps.lg),
          child: FilledButton(
            onPressed: _busy ? null : () => _save(schoolId),
            child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Simpan konten'),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.md, Gaps.xl, Gaps.xl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SegmentedButton<ArticleType>(
                    // Tanpa ikon: di layar sempit label "Beasiswa" terpotong menjadi dua baris.
                    showSelectedIcon: false,
                    segments: [
                      for (final type in ArticleType.values) ButtonSegment(value: type, label: Text(type.label)),
                    ],
                    selected: {_type},
                    onSelectionChanged: _busy ? null : (selection) => setState(() => _type = selection.first),
                  ),
                  const SizedBox(height: Gaps.lg),
                  TextFormField(
                    controller: _title,
                    enabled: !_busy,
                    maxLength: 140,
                    decoration: const InputDecoration(labelText: 'Judul'),
                    validator: (value) => (value ?? '').trim().length < 5 ? 'Judul minimal 5 karakter.' : null,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                    items: [
                      for (final entry in kArticleCategories.entries)
                        DropdownMenuItem(value: entry.key, child: Text(entry.value)),
                    ],
                    onChanged: _busy ? null : (value) => setState(() => _category = value ?? _category),
                  ),
                  const SizedBox(height: Gaps.lg),
                  TextFormField(
                    controller: _summary,
                    enabled: !_busy,
                    minLines: 2,
                    maxLines: 4,
                    maxLength: 300,
                    decoration: const InputDecoration(labelText: 'Ringkasan', alignLabelWithHint: true),
                    validator: (value) => (value ?? '').trim().length < 10 ? 'Ringkasan minimal 10 karakter.' : null,
                  ),
                  if (_type == ArticleType.artikel) ...[
                    TextFormField(
                      controller: _body,
                      enabled: !_busy,
                      minLines: 8,
                      maxLines: 20,
                      maxLength: 20000,
                      decoration: const InputDecoration(
                        labelText: 'Isi artikel (Markdown)',
                        alignLabelWithHint: true,
                        helperText: 'Gunakan **tebal**, *miring*, dan - untuk daftar.',
                      ),
                      validator: (value) => (value ?? '').trim().length < 30 ? 'Isi artikel minimal 30 karakter.' : null,
                    ),
                  ],
                  if (isLink)
                    TextFormField(
                      controller: _url,
                      enabled: !_busy,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(labelText: 'Tautan (https)'),
                      validator: (value) =>
                          (value ?? '').trim().startsWith('https://') ? null : 'Tautan harus diawali https://',
                    ),
                  if (isScholarship) ...[
                    TextFormField(
                      controller: _organizer,
                      enabled: !_busy,
                      decoration: const InputDecoration(labelText: 'Penyelenggara'),
                      validator: (value) => (value ?? '').trim().length < 2 ? 'Isi penyelenggara.' : null,
                    ),
                    TextFormField(
                      controller: _level,
                      enabled: !_busy,
                      decoration: const InputDecoration(labelText: 'Jenjang', hintText: 'Contoh: SMA/SMK'),
                      validator: (value) => (value ?? '').trim().length < 2 ? 'Isi jenjang.' : null,
                    ),
                    TextFormField(
                      controller: _deadline,
                      enabled: !_busy,
                      decoration: const InputDecoration(labelText: 'Tenggat (YYYY-MM-DD)', hintText: '2026-11-30'),
                      validator: (value) =>
                          RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch((value ?? '').trim()) ? null : 'Format tanggal: 2026-11-30',
                    ),
                    TextFormField(
                      controller: _scholarshipUrl,
                      enabled: !_busy,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(labelText: 'Tautan pendaftaran (https)'),
                      validator: (value) =>
                          (value ?? '').trim().startsWith('https://') ? null : 'Tautan harus diawali https://',
                    ),
                  ],
                  TextFormField(
                    controller: _cover,
                    enabled: !_busy,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(labelText: 'Gambar sampul (https, opsional)'),
                    validator: (value) {
                      final url = (value ?? '').trim();
                      return url.isEmpty || url.startsWith('https://') ? null : 'Tautan gambar harus https://';
                    },
                  ),
                  const SizedBox(height: Gaps.sm),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _published,
                    onChanged: _busy ? null : (value) => setState(() => _published = value),
                    title: const Text('Terbitkan'),
                    subtitle: const Text('Matikan untuk menyimpan sebagai draf.'),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _featured,
                    onChanged: _busy ? null : (value) => setState(() => _featured = value),
                    title: const Text('Jadikan unggulan'),
                    subtitle: const Text('Tampil di urutan atas daftar Edukasi.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
