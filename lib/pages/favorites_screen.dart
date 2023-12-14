// favorites_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
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

  // Método para cargar las noticias favoritas desde la base de datos
  Future<void> _loadFavorites() async {
    final updatedFavorites = await DatabaseHelper().getFavorites();
    setState(() {
      favorites = updatedFavorites;
    });
  }

  // Método para eliminar una noticia de la lista de favoritos y actualizar la interfaz
  void _removeFromFavorites(Article article) async {
    await DatabaseHelper().removeFavorite(article).then((_) {
      _loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text('No favorite articles yet.'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Widget personalizado para mostrar la imagen de la noticia
                      NewsCardImage(
                        imageUrl: favorites[index].urlToImage,
                      ),
                      ListTile(
                        title: Text(favorites[index].title),
                        subtitle: Text(favorites[index].description),
                        onTap: () {
                          // Abre la URL de la noticia al tocarla
                          _launchURL(favorites[index].url);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Icono de eliminar para quitar la noticia de favoritos
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _removeFromFavorites(favorites[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // Método para lanzar la URL de la noticia en el navegador
  void _launchURL(String url) async {
    // Implementa la función _launchURL según tu necesidad
  }
}

// Widget para mostrar la imagen de la noticia en la tarjeta de favoritos
class NewsCardImage extends StatelessWidget {
  final String imageUrl;

  NewsCardImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset(
        'assets/top_headlines.png',
        fit: BoxFit.contain,
        height: 200,
      ),
      fit: BoxFit.contain,
      height: 200,
      errorWidget: (context, url, error) {
        print('Error loading image: $error');
        return Text('Image not available');
      },
    );
  }
}



