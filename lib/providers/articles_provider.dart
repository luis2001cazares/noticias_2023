import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noticias_2023/models/models.dart';
import 'package:http/http.dart' as http;


class ArticlesProvider extends ChangeNotifier {
  String _baseUrl = 'https://newsapi.org';
  String _apiKey = '0f8396e404bd43c6b3e8a2392275809f';
  String _country = 'mx';

  List<Article> onDisplayArticles = [];
  //List<Article> popularMovies = [];
  //Map<int, List<Cast>> moviesCast = {};

  ArticlesProvider() {
    getOnDisplayArticles();
    //getPopularMovies();
  }

  getOnDisplayArticles() async {
    // var url = Uri.https(_baseUrl, '3/movie/now_playing',
    //     {'api_key': _apiKey, 'language': _language, 'page': '1'});
    var url = Uri.https(_baseUrl, 'v2/top-headlines',
        {'country': _country,'apikey': _apiKey});
    final response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);
    //print(decodeData);
    //print(response.body);
    final topHeadlinesResponse = TopHeadlinesResponse.fromRawJson(response.body);
    onDisplayArticles = topHeadlinesResponse.articles;
    // final topHeadlinesResponse = TopHeadlinesResponse.fromRawJson(response.body);
    // onDisplayArticles = topHeadlinesResponse.results;
    //Le comunicamos a todos los widgets que estan escuchando que se cambio la data por lo tanto se tienen que redibujar
    notifyListeners();
    //print(nowPLayingResponse.results[0].title);
  }
}