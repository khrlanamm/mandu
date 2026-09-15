// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(articleRepository)
final articleRepositoryProvider = ArticleRepositoryProvider._();

final class ArticleRepositoryProvider
    extends
        $FunctionalProvider<
          ArticleRepository,
          ArticleRepository,
          ArticleRepository
        >
    with $Provider<ArticleRepository> {
  ArticleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'articleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$articleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ArticleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ArticleRepository create(Ref ref) {
    return articleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticleRepository>(value),
    );
  }
}

String _$articleRepositoryHash() => r'e99a03ced7a17c79175dab3dd45e94d7f2d2aaef';

@ProviderFor(globalArticles)
final globalArticlesProvider = GlobalArticlesFamily._();

final class GlobalArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          Stream<List<Article>>
        >
    with $FutureModifier<List<Article>>, $StreamProvider<List<Article>> {
  GlobalArticlesProvider._({
    required GlobalArticlesFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'globalArticlesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$globalArticlesHash();

  @override
  String toString() {
    return r'globalArticlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Article>> create(Ref ref) {
    final argument = this.argument as bool;
    return globalArticles(ref, editorMode: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GlobalArticlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$globalArticlesHash() => r'c984961fff50350009b28f09ab6498bd0734070b';

final class GlobalArticlesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Article>>, bool> {
  GlobalArticlesFamily._()
    : super(
        retry: null,
        name: r'globalArticlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GlobalArticlesProvider call({bool editorMode = false}) =>
      GlobalArticlesProvider._(argument: editorMode, from: this);

  @override
  String toString() => r'globalArticlesProvider';
}

@ProviderFor(schoolArticles)
final schoolArticlesProvider = SchoolArticlesFamily._();

final class SchoolArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          Stream<List<Article>>
        >
    with $FutureModifier<List<Article>>, $StreamProvider<List<Article>> {
  SchoolArticlesProvider._({
    required SchoolArticlesFamily super.from,
    required (String, {bool editorMode}) super.argument,
  }) : super(
         retry: null,
         name: r'schoolArticlesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$schoolArticlesHash();

  @override
  String toString() {
    return r'schoolArticlesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Article>> create(Ref ref) {
    final argument = this.argument as (String, {bool editorMode});
    return schoolArticles(ref, argument.$1, editorMode: argument.editorMode);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolArticlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$schoolArticlesHash() => r'd5af8497511effedd68e664ccafd1e0275f44492';

final class SchoolArticlesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<Article>>,
          (String, {bool editorMode})
        > {
  SchoolArticlesFamily._()
    : super(
        retry: null,
        name: r'schoolArticlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SchoolArticlesProvider call(String schoolId, {bool editorMode = false}) =>
      SchoolArticlesProvider._(
        argument: (schoolId, editorMode: editorMode),
        from: this,
      );

  @override
  String toString() => r'schoolArticlesProvider';
}

/// Edukasi untuk siswa: gabungan artikel global dan artikel sekolah.

@ProviderFor(educationFeed)
final educationFeedProvider = EducationFeedProvider._();

/// Edukasi untuk siswa: gabungan artikel global dan artikel sekolah.

final class EducationFeedProvider
    extends $FunctionalProvider<List<Article>, List<Article>, List<Article>>
    with $Provider<List<Article>> {
  /// Edukasi untuk siswa: gabungan artikel global dan artikel sekolah.
  EducationFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'educationFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$educationFeedHash();

  @$internal
  @override
  $ProviderElement<List<Article>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Article> create(Ref ref) {
    return educationFeed(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Article> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Article>>(value),
    );
  }
}

String _$educationFeedHash() => r'dea92030a3b5fd7c3f61ff71116dda6b909f705f';

@ProviderFor(article)
final articleProvider = ArticleFamily._();

final class ArticleProvider
    extends
        $FunctionalProvider<AsyncValue<Article?>, Article?, Stream<Article?>>
    with $FutureModifier<Article?>, $StreamProvider<Article?> {
  ArticleProvider._({
    required ArticleFamily super.from,
    required (String, {String? schoolId}) super.argument,
  }) : super(
         retry: null,
         name: r'articleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleHash();

  @override
  String toString() {
    return r'articleProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Article?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Article?> create(Ref ref) {
    final argument = this.argument as (String, {String? schoolId});
    return article(ref, argument.$1, schoolId: argument.schoolId);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleHash() => r'c4dddf737843c2711fe766cee647786aebcaa457';

final class ArticleFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<Article?>,
          (String, {String? schoolId})
        > {
  ArticleFamily._()
    : super(
        retry: null,
        name: r'articleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleProvider call(String articleId, {String? schoolId}) =>
      ArticleProvider._(argument: (articleId, schoolId: schoolId), from: this);

  @override
  String toString() => r'articleProvider';
}

@ProviderFor(bookmarks)
final bookmarksProvider = BookmarksProvider._();

final class BookmarksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bookmark>>,
          List<Bookmark>,
          Stream<List<Bookmark>>
        >
    with $FutureModifier<List<Bookmark>>, $StreamProvider<List<Bookmark>> {
  BookmarksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarksHash();

  @$internal
  @override
  $StreamProviderElement<List<Bookmark>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Bookmark>> create(Ref ref) {
    return bookmarks(ref);
  }
}

String _$bookmarksHash() => r'ca710f41e4468cfc45fc2aea18c209343bd4dd96';

/// Peran yang boleh menulis konten Edukasi sekolah.

@ProviderFor(canEditSchoolArticles)
final canEditSchoolArticlesProvider = CanEditSchoolArticlesProvider._();

/// Peran yang boleh menulis konten Edukasi sekolah.

final class CanEditSchoolArticlesProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Peran yang boleh menulis konten Edukasi sekolah.
  CanEditSchoolArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'canEditSchoolArticlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$canEditSchoolArticlesHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return canEditSchoolArticles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$canEditSchoolArticlesHash() =>
    r'588362e11c36090d60a285a7288764b18f1ef33c';
