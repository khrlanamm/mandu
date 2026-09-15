// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Scholarship {

 String get organizer; String get level; String get deadline; String get url;
/// Create a copy of Scholarship
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScholarshipCopyWith<Scholarship> get copyWith => _$ScholarshipCopyWithImpl<Scholarship>(this as Scholarship, _$identity);

  /// Serializes this Scholarship to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Scholarship;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Scholarship&&(identical(other.organizer, _this.organizer) || other.organizer == _this.organizer)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.deadline, _this.deadline) || other.deadline == _this.deadline)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Scholarship;
  return Object.hash(runtimeType,_this.organizer,_this.level,_this.deadline,_this.url);
}

@override
String toString() {
  final _this = this as Scholarship;
  return 'Scholarship(organizer: ${_this.organizer}, level: ${_this.level}, deadline: ${_this.deadline}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $ScholarshipCopyWith<$Res>  {
  factory $ScholarshipCopyWith(Scholarship value, $Res Function(Scholarship) _then) = _$ScholarshipCopyWithImpl;
@useResult
$Res call({
 String organizer, String level, String deadline, String url
});




}
/// @nodoc
class _$ScholarshipCopyWithImpl<$Res>
    implements $ScholarshipCopyWith<$Res> {
  _$ScholarshipCopyWithImpl(this._self, this._then);

  final Scholarship _self;
  final $Res Function(Scholarship) _then;

/// Create a copy of Scholarship
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizer = null,Object? level = null,Object? deadline = null,Object? url = null,}) {
  return _then(Scholarship(
organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Scholarship].
extension ScholarshipPatterns on Scholarship {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Scholarship value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Scholarship() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Scholarship value)  $default,){
final _that = this;
switch (_that) {
case _Scholarship():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Scholarship value)?  $default,){
final _that = this;
switch (_that) {
case _Scholarship() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizer,  String level,  String deadline,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Scholarship() when $default != null:
return $default(_that.organizer,_that.level,_that.deadline,_that.url);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizer,  String level,  String deadline,  String url)  $default,) {final _that = this;
switch (_that) {
case _Scholarship():
return $default(_that.organizer,_that.level,_that.deadline,_that.url);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizer,  String level,  String deadline,  String url)?  $default,) {final _that = this;
switch (_that) {
case _Scholarship() when $default != null:
return $default(_that.organizer,_that.level,_that.deadline,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Scholarship extends Scholarship {
  const _Scholarship({this.organizer = '', this.level = '', this.deadline = '', this.url = ''}): super._();
  factory _Scholarship.fromJson(Map<String, dynamic> json) => _$ScholarshipFromJson(json);

@override@JsonKey() final  String organizer;
@override@JsonKey() final  String level;
@override@JsonKey() final  String deadline;
@override@JsonKey() final  String url;

/// Create a copy of Scholarship
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScholarshipCopyWith<_Scholarship> get copyWith => __$ScholarshipCopyWithImpl<_Scholarship>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScholarshipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Scholarship&&(identical(other.organizer, organizer) || other.organizer == organizer)&&(identical(other.level, level) || other.level == level)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,organizer,level,deadline,url);
}

@override
String toString() {
    return 'Scholarship(organizer: $organizer, level: $level, deadline: $deadline, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ScholarshipCopyWith<$Res> implements $ScholarshipCopyWith<$Res> {
  factory _$ScholarshipCopyWith(_Scholarship value, $Res Function(_Scholarship) _then) = __$ScholarshipCopyWithImpl;
@override @useResult
$Res call({
 String organizer, String level, String deadline, String url
});




}
/// @nodoc
class __$ScholarshipCopyWithImpl<$Res>
    implements _$ScholarshipCopyWith<$Res> {
  __$ScholarshipCopyWithImpl(this._self, this._then);

  final _Scholarship _self;
  final $Res Function(_Scholarship) _then;

/// Create a copy of Scholarship
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizer = null,Object? level = null,Object? deadline = null,Object? url = null,}) {
  return _then(_Scholarship(
organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Article {

 String get id; String get title; String get category; String get categoryLabel;@JsonKey(unknownEnumValue: ArticleType.artikel) ArticleType get type; String get summary; String get body; String? get url; String? get coverUrl; Scholarship? get scholarship; bool get featured; bool get published; int get views; String get scope; String? get schoolId; String get authorName;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get publishedAt;
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleCopyWith<Article> get copyWith => _$ArticleCopyWithImpl<Article>(this as Article, _$identity);

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Article;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Article&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.categoryLabel, _this.categoryLabel) || other.categoryLabel == _this.categoryLabel)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.coverUrl, _this.coverUrl) || other.coverUrl == _this.coverUrl)&&(identical(other.scholarship, _this.scholarship) || other.scholarship == _this.scholarship)&&(identical(other.featured, _this.featured) || other.featured == _this.featured)&&(identical(other.published, _this.published) || other.published == _this.published)&&(identical(other.views, _this.views) || other.views == _this.views)&&(identical(other.scope, _this.scope) || other.scope == _this.scope)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Article;
  return Object.hash(runtimeType,_this.id,_this.title,_this.category,_this.categoryLabel,_this.type,_this.summary,_this.body,_this.url,_this.coverUrl,_this.scholarship,_this.featured,_this.published,_this.views,_this.scope,_this.schoolId,_this.authorName,_this.createdAt,_this.publishedAt);
}

@override
String toString() {
  final _this = this as Article;
  return 'Article(id: ${_this.id}, title: ${_this.title}, category: ${_this.category}, categoryLabel: ${_this.categoryLabel}, type: ${_this.type}, summary: ${_this.summary}, body: ${_this.body}, url: ${_this.url}, coverUrl: ${_this.coverUrl}, scholarship: ${_this.scholarship}, featured: ${_this.featured}, published: ${_this.published}, views: ${_this.views}, scope: ${_this.scope}, schoolId: ${_this.schoolId}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt}, publishedAt: ${_this.publishedAt})';
}


}

/// @nodoc
abstract mixin class $ArticleCopyWith<$Res>  {
  factory $ArticleCopyWith(Article value, $Res Function(Article) _then) = _$ArticleCopyWithImpl;
@useResult
$Res call({
 String id, String title, String category, String categoryLabel,@JsonKey(unknownEnumValue: ArticleType.artikel) ArticleType type, String summary, String body, String? url, String? coverUrl, Scholarship? scholarship, bool featured, bool published, int views, String scope, String? schoolId, String authorName,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? publishedAt
});


$ScholarshipCopyWith<$Res>? get scholarship;

}
/// @nodoc
class _$ArticleCopyWithImpl<$Res>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._self, this._then);

  final Article _self;
  final $Res Function(Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? categoryLabel = null,Object? type = null,Object? summary = null,Object? body = null,Object? url = freezed,Object? coverUrl = freezed,Object? scholarship = freezed,Object? featured = null,Object? published = null,Object? views = null,Object? scope = null,Object? schoolId = freezed,Object? authorName = null,Object? createdAt = freezed,Object? publishedAt = freezed,}) {
  return _then(Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,scholarship: freezed == scholarship ? _self.scholarship : scholarship // ignore: cast_nullable_to_non_nullable
as Scholarship?,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,published: null == published ? _self.published : published // ignore: cast_nullable_to_non_nullable
as bool,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScholarshipCopyWith<$Res>? get scholarship {
    if (_self.scholarship == null) {
    return null;
  }

  return $ScholarshipCopyWith<$Res>(_self.scholarship!, (value) {
    return _then(_self.copyWith(scholarship: value));
  });
}
}


/// Adds pattern-matching-related methods to [Article].
extension ArticlePatterns on Article {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Article value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Article value)  $default,){
final _that = this;
switch (_that) {
case _Article():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Article value)?  $default,){
final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String categoryLabel, @JsonKey(unknownEnumValue: ArticleType.artikel)  ArticleType type,  String summary,  String body,  String? url,  String? coverUrl,  Scholarship? scholarship,  bool featured,  bool published,  int views,  String scope,  String? schoolId,  String authorName, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? publishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.categoryLabel,_that.type,_that.summary,_that.body,_that.url,_that.coverUrl,_that.scholarship,_that.featured,_that.published,_that.views,_that.scope,_that.schoolId,_that.authorName,_that.createdAt,_that.publishedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String categoryLabel, @JsonKey(unknownEnumValue: ArticleType.artikel)  ArticleType type,  String summary,  String body,  String? url,  String? coverUrl,  Scholarship? scholarship,  bool featured,  bool published,  int views,  String scope,  String? schoolId,  String authorName, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? publishedAt)  $default,) {final _that = this;
switch (_that) {
case _Article():
return $default(_that.id,_that.title,_that.category,_that.categoryLabel,_that.type,_that.summary,_that.body,_that.url,_that.coverUrl,_that.scholarship,_that.featured,_that.published,_that.views,_that.scope,_that.schoolId,_that.authorName,_that.createdAt,_that.publishedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String category,  String categoryLabel, @JsonKey(unknownEnumValue: ArticleType.artikel)  ArticleType type,  String summary,  String body,  String? url,  String? coverUrl,  Scholarship? scholarship,  bool featured,  bool published,  int views,  String scope,  String? schoolId,  String authorName, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? publishedAt)?  $default,) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.categoryLabel,_that.type,_that.summary,_that.body,_that.url,_that.coverUrl,_that.scholarship,_that.featured,_that.published,_that.views,_that.scope,_that.schoolId,_that.authorName,_that.createdAt,_that.publishedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Article extends Article {
  const _Article({required this.id, this.title = '', this.category = 'lainnya', this.categoryLabel = '', @JsonKey(unknownEnumValue: ArticleType.artikel) this.type = ArticleType.artikel, this.summary = '', this.body = '', this.url, this.coverUrl, this.scholarship, this.featured = false, this.published = true, this.views = 0, this.scope = 'global', this.schoolId, this.authorName = '', @TimestampConverter() this.createdAt, @TimestampConverter() this.publishedAt}): super._();
  factory _Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

@override final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String category;
@override@JsonKey() final  String categoryLabel;
@override@JsonKey(unknownEnumValue: ArticleType.artikel) final  ArticleType type;
@override@JsonKey() final  String summary;
@override@JsonKey() final  String body;
@override final  String? url;
@override final  String? coverUrl;
@override final  Scholarship? scholarship;
@override@JsonKey() final  bool featured;
@override@JsonKey() final  bool published;
@override@JsonKey() final  int views;
@override@JsonKey() final  String scope;
@override final  String? schoolId;
@override@JsonKey() final  String authorName;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? publishedAt;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleCopyWith<_Article> get copyWith => __$ArticleCopyWithImpl<_Article>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.body, body) || other.body == body)&&(identical(other.url, url) || other.url == url)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.scholarship, scholarship) || other.scholarship == scholarship)&&(identical(other.featured, featured) || other.featured == featured)&&(identical(other.published, published) || other.published == published)&&(identical(other.views, views) || other.views == views)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,category,categoryLabel,type,summary,body,url,coverUrl,scholarship,featured,published,views,scope,schoolId,authorName,createdAt,publishedAt);
}

@override
String toString() {
    return 'Article(id: $id, title: $title, category: $category, categoryLabel: $categoryLabel, type: $type, summary: $summary, body: $body, url: $url, coverUrl: $coverUrl, scholarship: $scholarship, featured: $featured, published: $published, views: $views, scope: $scope, schoolId: $schoolId, authorName: $authorName, createdAt: $createdAt, publishedAt: $publishedAt)';
}


}

/// @nodoc
abstract mixin class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) _then) = __$ArticleCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String category, String categoryLabel,@JsonKey(unknownEnumValue: ArticleType.artikel) ArticleType type, String summary, String body, String? url, String? coverUrl, Scholarship? scholarship, bool featured, bool published, int views, String scope, String? schoolId, String authorName,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? publishedAt
});


@override $ScholarshipCopyWith<$Res>? get scholarship;

}
/// @nodoc
class __$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(this._self, this._then);

  final _Article _self;
  final $Res Function(_Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? categoryLabel = null,Object? type = null,Object? summary = null,Object? body = null,Object? url = freezed,Object? coverUrl = freezed,Object? scholarship = freezed,Object? featured = null,Object? published = null,Object? views = null,Object? scope = null,Object? schoolId = freezed,Object? authorName = null,Object? createdAt = freezed,Object? publishedAt = freezed,}) {
  return _then(_Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,scholarship: freezed == scholarship ? _self.scholarship : scholarship // ignore: cast_nullable_to_non_nullable
as Scholarship?,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as bool,published: null == published ? _self.published : published // ignore: cast_nullable_to_non_nullable
as bool,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScholarshipCopyWith<$Res>? get scholarship {
    if (_self.scholarship == null) {
    return null;
  }

  return $ScholarshipCopyWith<$Res>(_self.scholarship!, (value) {
    return _then(_self.copyWith(scholarship: value));
  });
}
}


/// @nodoc
mixin _$Bookmark {

 String get id; String get scope; String? get schoolId; String get title;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of Bookmark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookmarkCopyWith<Bookmark> get copyWith => _$BookmarkCopyWithImpl<Bookmark>(this as Bookmark, _$identity);

  /// Serializes this Bookmark to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Bookmark;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bookmark&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.scope, _this.scope) || other.scope == _this.scope)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Bookmark;
  return Object.hash(runtimeType,_this.id,_this.scope,_this.schoolId,_this.title,_this.createdAt);
}

@override
String toString() {
  final _this = this as Bookmark;
  return 'Bookmark(id: ${_this.id}, scope: ${_this.scope}, schoolId: ${_this.schoolId}, title: ${_this.title}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $BookmarkCopyWith<$Res>  {
  factory $BookmarkCopyWith(Bookmark value, $Res Function(Bookmark) _then) = _$BookmarkCopyWithImpl;
@useResult
$Res call({
 String id, String scope, String? schoolId, String title,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$BookmarkCopyWithImpl<$Res>
    implements $BookmarkCopyWith<$Res> {
  _$BookmarkCopyWithImpl(this._self, this._then);

  final Bookmark _self;
  final $Res Function(Bookmark) _then;

/// Create a copy of Bookmark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scope = null,Object? schoolId = freezed,Object? title = null,Object? createdAt = freezed,}) {
  return _then(Bookmark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Bookmark].
extension BookmarkPatterns on Bookmark {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bookmark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bookmark() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bookmark value)  $default,){
final _that = this;
switch (_that) {
case _Bookmark():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bookmark value)?  $default,){
final _that = this;
switch (_that) {
case _Bookmark() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String scope,  String? schoolId,  String title, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bookmark() when $default != null:
return $default(_that.id,_that.scope,_that.schoolId,_that.title,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String scope,  String? schoolId,  String title, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Bookmark():
return $default(_that.id,_that.scope,_that.schoolId,_that.title,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String scope,  String? schoolId,  String title, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Bookmark() when $default != null:
return $default(_that.id,_that.scope,_that.schoolId,_that.title,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bookmark implements Bookmark {
  const _Bookmark({required this.id, this.scope = 'global', this.schoolId, this.title = '', @TimestampConverter() this.createdAt});
  factory _Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);

@override final  String id;
@override@JsonKey() final  String scope;
@override final  String? schoolId;
@override@JsonKey() final  String title;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of Bookmark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookmarkCopyWith<_Bookmark> get copyWith => __$BookmarkCopyWithImpl<_Bookmark>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookmarkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bookmark&&(identical(other.id, id) || other.id == id)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,scope,schoolId,title,createdAt);
}

@override
String toString() {
    return 'Bookmark(id: $id, scope: $scope, schoolId: $schoolId, title: $title, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookmarkCopyWith<$Res> implements $BookmarkCopyWith<$Res> {
  factory _$BookmarkCopyWith(_Bookmark value, $Res Function(_Bookmark) _then) = __$BookmarkCopyWithImpl;
@override @useResult
$Res call({
 String id, String scope, String? schoolId, String title,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$BookmarkCopyWithImpl<$Res>
    implements _$BookmarkCopyWith<$Res> {
  __$BookmarkCopyWithImpl(this._self, this._then);

  final _Bookmark _self;
  final $Res Function(_Bookmark) _then;

/// Create a copy of Bookmark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? scope = null,Object? schoolId = freezed,Object? title = null,Object? createdAt = freezed,}) {
  return _then(_Bookmark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
