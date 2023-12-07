import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsProvider {
  final String apiKey;
  final String country;

  NewsProvider({required this.apiKey, required this.country});

  Future<List<Article>> getTopHeadlines() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body)['articles'];
      return compute(parseArticles, articlesJson);
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  static List<Article> parseArticles(List<dynamic> articlesJson) {
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  }
}
