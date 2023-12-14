// article_model.dart
class Article {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  // Constructor que recibe los atributos requeridos para crear una instancia de Article
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // Factoría para crear una instancia de Article desde un mapa JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      // Mapea los valores del JSON a los atributos de la clase Article
      source: json['source']['name'],
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  // Método para convertir una instancia de Article a un mapa
  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}


