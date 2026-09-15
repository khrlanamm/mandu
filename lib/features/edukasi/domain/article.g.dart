// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Scholarship _$ScholarshipFromJson(Map<String, dynamic> json) => _Scholarship(
  organizer: json['organizer'] as String? ?? '',
  level: json['level'] as String? ?? '',
  deadline: json['deadline'] as String? ?? '',
  url: json['url'] as String? ?? '',
);

Map<String, dynamic> _$ScholarshipToJson(_Scholarship instance) =>
    <String, dynamic>{
      'organizer': instance.organizer,
      'level': instance.level,
      'deadline': instance.deadline,
      'url': instance.url,
    };

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: json['id'] as String,
  title: json['title'] as String? ?? '',
  category: json['category'] as String? ?? 'lainnya',
  categoryLabel: json['categoryLabel'] as String? ?? '',
  type:
      $enumDecodeNullable(
        _$ArticleTypeEnumMap,
        json['type'],
        unknownValue: ArticleType.artikel,
      ) ??
      ArticleType.artikel,
  summary: json['summary'] as String? ?? '',
  body: json['body'] as String? ?? '',
  url: json['url'] as String?,
  coverUrl: json['coverUrl'] as String?,
  scholarship: json['scholarship'] == null
      ? null
      : Scholarship.fromJson(json['scholarship'] as Map<String, dynamic>),
  featured: json['featured'] as bool? ?? false,
  published: json['published'] as bool? ?? true,
  views: (json['views'] as num?)?.toInt() ?? 0,
  scope: json['scope'] as String? ?? 'global',
  schoolId: json['schoolId'] as String?,
  authorName: json['authorName'] as String? ?? '',
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  publishedAt: const TimestampConverter().fromJson(json['publishedAt']),
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'categoryLabel': instance.categoryLabel,
  'type': _$ArticleTypeEnumMap[instance.type]!,
  'summary': instance.summary,
  'body': instance.body,
  'url': instance.url,
  'coverUrl': instance.coverUrl,
  'scholarship': instance.scholarship?.toJson(),
  'featured': instance.featured,
  'published': instance.published,
  'views': instance.views,
  'scope': instance.scope,
  'schoolId': instance.schoolId,
  'authorName': instance.authorName,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'publishedAt': const TimestampConverter().toJson(instance.publishedAt),
};

const _$ArticleTypeEnumMap = {
  ArticleType.artikel: 'artikel',
  ArticleType.tautan: 'tautan',
  ArticleType.beasiswa: 'beasiswa',
};

_Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => _Bookmark(
  id: json['id'] as String,
  scope: json['scope'] as String? ?? 'global',
  schoolId: json['schoolId'] as String?,
  title: json['title'] as String? ?? '',
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$BookmarkToJson(_Bookmark instance) => <String, dynamic>{
  'id': instance.id,
  'scope': instance.scope,
  'schoolId': instance.schoolId,
  'title': instance.title,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
