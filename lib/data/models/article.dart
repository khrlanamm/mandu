/// Dokumen koleksi `articles`.
class Article {
  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
  });

  factory Article.fromMap(Map<String, dynamic> data) {
    return Article(
      id: (data['id'] as num?)?.toInt() ?? 0,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      image: data['image'] as String? ?? '',
      url: data['url'] as String? ?? '',
    );
  }

  final int id;
  final String title;
  final String description;
  final String image;
  final String url;

  bool get hasSecureUrl => Uri.tryParse(url)?.scheme == 'https';
}
