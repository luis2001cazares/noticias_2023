// search_screen.dart
import 'package:flutter/material.dart';
import '../providers/news_provider.dart';
import '../models/article_model.dart';
import '../widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  final NewsProvider newsProvider;

  SearchScreen({required this.newsProvider});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Article> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Keyword',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String keyword = _searchController.text;
                searchResults = await widget.newsProvider.searchNews(keyword);
                setState(() {}); // Actualiza la interfaz de usuario con los resultados
              },
              child: Text('Search'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return NewsCard(article: searchResults[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
