// news_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsProvider {
  final String apiKey;
  String country;

  // Constructor para inicializar la instancia con una clave de API y un país predeterminado
  NewsProvider({required this.apiKey, required this.country});

  // Método para actualizar el país actual
  void updateCountry(String newCountry) {
    country = newCountry;
  }

  // Método asincrónico para obtener las principales noticias
  Future<List<Article>> getTopHeadlines({int? articlesCount}) async {
    // Se realiza una solicitud HTTP GET a la API de noticias
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa (código 200), se parsea el JSON y se crea una lista de objetos Article
      final List<dynamic> articlesJson = json.decode(response.body)['articles'];
      final List<Article> articles = parseArticles(articlesJson);

      // Si se especifica un límite de artículos, se devuelve solo esa cantidad
      if (articlesCount != null && articlesCount < articles.length) {
        return articles.take(articlesCount).toList();
      }

      // Si no se especifica un límite, o el límite es mayor que la cantidad total de artículos, se devuelve la lista completa
      return articles;
    } else {
      // Si la respuesta no es exitosa, se lanza una excepción con el código de estado
      throw Exception('Failed to load top headlines. Status code: ${response.statusCode}');
    }
  }

  // Método asincrónico para buscar noticias por palabra clave
  Future<List<Article>> searchNews(String keyword, {int? articlesCount}) async {
    // Se realiza una solicitud HTTP GET a la API de noticias para buscar
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa (código 200), se parsea el JSON y se crea una lista de objetos Article
      final List<dynamic> articlesJson = json.decode(response.body)['articles'];
      final List<Article> articles = parseArticles(articlesJson);

      // Si se especifica un límite de artículos, se devuelve solo esa cantidad
      if (articlesCount != null && articlesCount < articles.length) {
        return articles.take(articlesCount).toList();
      }

      // Si no se especifica un límite, o el límite es mayor que la cantidad total de artículos, se devuelve la lista completa
      return articles;
    } else {
      // Si la respuesta no es exitosa, se lanza una excepción con el código de estado
      throw Exception('Failed to load search results. Status code: ${response.statusCode}');
    }
  }

  // Método estático para parsear una lista de artículos desde JSON
  static List<Article> parseArticles(List<dynamic> articlesJson) {
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  }
}



