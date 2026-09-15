import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/firebase/callable.dart';

part 'article.freezed.dart';
part 'article.g.dart';

/// Salinan dari functions/src/domain/education.ts — ubah keduanya bersamaan.
const kArticleCategories = {
  'anti_bullying': 'Anti-Perundungan',
  'kesehatan_mental': 'Kesehatan Mental Remaja',
  'etika_digital': 'Etika Digital',
  'hak_kewajiban': 'Hak & Kewajiban Siswa',
  'cari_bantuan': 'Cara Mencari Bantuan',
  'keamanan_sekolah': 'Keamanan Sekolah',
  'layanan_bk': 'Layanan BK',
  'beasiswa': 'Beasiswa',
};

enum ArticleType {
  artikel('Artikel', Icons.article_outlined),
  tautan('Tautan', Icons.link_rounded),
  beasiswa('Beasiswa', Icons.school_outlined);

  const ArticleType(this.label, this.icon);

  final String label;
  final IconData icon;
}

@freezed
abstract class Scholarship with _$Scholarship {
  const Scholarship._();

  const factory Scholarship({
    @Default('') String organizer,
    @Default('') String level,
    @Default('') String deadline,
    @Default('') String url,
  }) = _Scholarship;

  factory Scholarship.fromJson(Map<String, dynamic> json) => _$ScholarshipFromJson(json);

  DateTime? get deadlineDate => DateTime.tryParse(deadline);

  bool get isExpired {
    final date = deadlineDate;
    return date != null && date.isBefore(DateTime.now());
  }
}

/// Dokumen `articles/{id}` (global) atau `schools/{schoolId}/articles/{id}`.
@freezed
abstract class Article with _$Article {
  const Article._();

  const factory Article({
    required String id,
    @Default('') String title,
    @Default('lainnya') String category,
    @Default('') String categoryLabel,
    @JsonKey(unknownEnumValue: ArticleType.artikel) @Default(ArticleType.artikel) ArticleType type,
    @Default('') String summary,
    @Default('') String body,
    String? url,
    String? coverUrl,
    Scholarship? scholarship,
    @Default(false) bool featured,
    @Default(true) bool published,
    @Default(0) int views,
    @Default('global') String scope,
    String? schoolId,
    @Default('') String authorName,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? publishedAt,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  bool get isGlobal => scope == 'global';

  /// ID bookmark yang stabil untuk artikel global maupun sekolah.
  String get bookmarkId => '${schoolId ?? 'global'}__$id';
}

/// Dokumen `users/{uid}/bookmarks/{bookmarkId}`.
@freezed
abstract class Bookmark with _$Bookmark {
  const factory Bookmark({
    required String id,
    @Default('global') String scope,
    String? schoolId,
    @Default('') String title,
    @TimestampConverter() DateTime? createdAt,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
}

/// Isian editor Edukasi.
class ArticleDraft {
  const ArticleDraft({
    this.articleId,
    this.schoolId,
    required this.title,
    required this.category,
    required this.type,
    required this.summary,
    this.body = '',
    this.url,
    this.coverUrl,
    this.scholarship,
    this.featured = false,
    this.published = true,
  });

  final String? articleId;

  /// null = artikel global (superadmin).
  final String? schoolId;
  final String title;
  final String category;
  final ArticleType type;
  final String summary;
  final String body;
  final String? url;
  final String? coverUrl;
  final Scholarship? scholarship;
  final bool featured;
  final bool published;

  Map<String, Object?> toJson() => {
        'articleId': ?articleId,
        'schoolId': schoolId,
        'title': title.trim(),
        'category': category,
        'type': type.name,
        'summary': summary.trim(),
        'body': body.trim(),
        'url': url == null || url!.trim().isEmpty ? null : url!.trim(),
        'coverUrl': coverUrl == null || coverUrl!.trim().isEmpty ? null : coverUrl!.trim(),
        'scholarship': scholarship == null
            ? null
            : {
                'organizer': scholarship!.organizer.trim(),
                'level': scholarship!.level.trim(),
                'deadline': scholarship!.deadline.trim(),
                'url': scholarship!.url.trim(),
              },
        'featured': featured,
        'published': published,
      };
}
