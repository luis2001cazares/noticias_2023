import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noticias_2023/models/article.dart';
import 'package:http/http.dart' as http;

class ArticlesProvider extends ChangeNotifier {
  String _baseUrl = 'https://newsapi.org/v2';
  String _apiKey = '0f8396e404bd43c6b3e8a2392275809f'; // Reemplaza 'tu_clave_de_api' con tu clave de API válida
  String _country = 'mx';

  List<Article> onDisplayArticles = [];

  Future<void> getOnDisplayArticles() async {
    final url = '$_baseUrl/top-headlines?country=$_country&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articlesData = data['articles'];

        onDisplayArticles = articlesData
            .map((articleData) => Article.fromMap(articleData))
            .toList();

        notifyListeners();
      } else {
        // Manejar errores de solicitud aquí
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de red aquí
      print('Error de red: $e');
    }
  }
}
