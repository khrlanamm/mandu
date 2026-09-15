import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/article.dart';

class ArticleRepository {
  ArticleRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static final instance = ArticleRepository();

  final FirebaseFirestore _firestore;

  Future<List<Article>> fetchArticles() async {
    final snapshot = await _firestore.collection('articles').orderBy('id').get();
    return snapshot.docs.map((doc) => Article.fromMap(doc.data())).toList();
  }
}
