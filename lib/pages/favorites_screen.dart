// favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:noticias_2023/databases/database_helper.dart';
import '../models/article_model.dart';
import '../widgets/news_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Article> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    favorites = await DatabaseHelper().getFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return NewsCard(article: favorites[index]);
        },
      ),
    );
  }
}
