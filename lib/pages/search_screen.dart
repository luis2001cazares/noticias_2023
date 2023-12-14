// search_screen.dart
import 'package:flutter/material.dart';
import '../providers/news_provider.dart';
import '../models/article_model.dart';
import '../widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  final NewsProvider newsProvider;

  // Constructor que requiere un NewsProvider
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
            // Campo de texto para ingresar la palabra clave de búsqueda
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Keyword',
              ),
            ),
            SizedBox(height: 16),
            // Botón para iniciar la búsqueda
            ElevatedButton(
              onPressed: () async {
                // Obtiene la palabra clave ingresada por el usuario
                String keyword = _searchController.text;
                // Realiza la búsqueda utilizando el NewsProvider
                searchResults = await widget.newsProvider.searchNews(keyword);
                // Actualiza la interfaz de usuario con los resultados
                setState(() {});
              },
              child: Text('Search'),
            ),
            // Lista de resultados de búsqueda
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  // Utiliza el widget NewsCard para mostrar cada resultado de búsqueda
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

