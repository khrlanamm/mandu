import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/roles.dart';
import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../auth/application/session_controller.dart';
import '../domain/article.dart';

part 'article_repository.g.dart';

class ArticleRepository {
  const ArticleRepository(this._functions, this._firestore);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _articles(String? schoolId) => schoolId == null
      ? _firestore.collection('articles')
      : _firestore.collection('schools').doc(schoolId).collection('articles');

  List<Article> _parse(QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((doc) => Article.fromJson(docWithId(doc))).toList();

  /// Artikel terbit; [editorMode] menyertakan draf untuk penulis konten.
  Stream<List<Article>> watchArticles({String? schoolId, bool editorMode = false}) {
    Query<Map<String, dynamic>> query = _articles(schoolId);
    if (!editorMode) query = query.where('published', isEqualTo: true);
    return query.orderBy('createdAt', descending: true).limit(200).snapshots().map(_parse);
  }

  Future<String> save(ArticleDraft draft) async {
    final data = await _functions.callMap('articles-save', draft.toJson());
    return data['articleId'] as String;
  }

  Future<void> delete({required String articleId, String? schoolId}) =>
      _functions.callMap('articles-delete', {'articleId': articleId, 'schoolId': schoolId});

  Future<void> markRead({required String articleId, String? schoolId}) =>
      _functions.callMap('articles-markRead', {'articleId': articleId, 'schoolId': schoolId});

  Stream<Article?> watchArticle({required String articleId, String? schoolId}) => _articles(schoolId)
      .doc(articleId)
      .snapshots()
      .map((snapshot) => snapshot.exists ? Article.fromJson(docWithId(snapshot)) : null);

  CollectionReference<Map<String, dynamic>> _bookmarks(String uid) =>
      _firestore.collection('users').doc(uid).collection('bookmarks');

  Stream<List<Bookmark>> watchBookmarks(String uid) => _bookmarks(uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Bookmark.fromJson(docWithId(doc))).toList());

  Future<void> toggleBookmark({required String uid, required Article article, required bool save}) {
    final ref = _bookmarks(uid).doc(article.bookmarkId);
    if (!save) return ref.delete();
    return ref.set({
      'scope': article.scope,
      'schoolId': article.schoolId,
      'title': article.title,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

@Riverpod(keepAlive: true)
ArticleRepository articleRepository(Ref ref) =>
    ArticleRepository(ref.watch(functionsProvider), ref.watch(firestoreProvider));

@riverpod
Stream<List<Article>> globalArticles(Ref ref, {bool editorMode = false}) =>
    ref.watch(articleRepositoryProvider).watchArticles(editorMode: editorMode);

@riverpod
Stream<List<Article>> schoolArticles(Ref ref, String schoolId, {bool editorMode = false}) =>
    ref.watch(articleRepositoryProvider).watchArticles(schoolId: schoolId, editorMode: editorMode);

/// Edukasi untuk siswa: gabungan artikel global dan artikel sekolah.
@riverpod
List<Article> educationFeed(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  final global = ref.watch(globalArticlesProvider()).value ?? const [];
  final school = account?.schoolId == null ? const <Article>[] : ref.watch(schoolArticlesProvider(account!.schoolId!)).value ?? const [];
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  return [...school, ...global]..sort((a, b) {
      if (a.featured != b.featured) return a.featured ? -1 : 1;
      return (b.createdAt ?? epoch).compareTo(a.createdAt ?? epoch);
    });
}

@riverpod
Stream<Article?> article(Ref ref, String articleId, {String? schoolId}) =>
    ref.watch(articleRepositoryProvider).watchArticle(articleId: articleId, schoolId: schoolId);

@riverpod
Stream<List<Bookmark>> bookmarks(Ref ref) {
  final uid = ref.watch(currentAccountProvider)?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(articleRepositoryProvider).watchBookmarks(uid);
}

/// Peran yang boleh menulis konten Edukasi sekolah.
@riverpod
bool canEditSchoolArticles(Ref ref) {
  final role = ref.watch(currentAccountProvider)?.role;
  return role == SchoolRole.admin || role == SchoolRole.konselor;
}
