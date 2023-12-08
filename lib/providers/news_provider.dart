// news_provider.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsProvider {
  final String apiKey;
  String country;

  NewsProvider({required this.apiKey, required this.country});

  void updateCountry(String newCountry) {
    country = newCountry;
  }

  Future<List<Article>> getTopHeadlines({int? articlesCount}) async {
    // Método actual - obtiene las principales noticias
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body)['articles'];
      final List<Article> articles = parseArticles(articlesJson);

      if (articlesCount != null && articlesCount < articles.length) {
        return articles.take(articlesCount).toList();
      }

      return articles;
    } else {
      throw Exception('Failed to load top headlines. Status code: ${response.statusCode}');
    }
  }

  Future<List<Article>> searchNews(String keyword, {int? articlesCount}) async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body)['articles'];
      final List<Article> articles = parseArticles(articlesJson);

      if (articlesCount != null && articlesCount < articles.length) {
        return articles.take(articlesCount).toList();
      }

      return articles;
    } else {
      throw Exception('Failed to load search results. Status code: ${response.statusCode}');
    }
  }

  static List<Article> parseArticles(List<dynamic> articlesJson) {
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  }
}


