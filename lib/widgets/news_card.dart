// news_card.dart
import 'package:flutter/material.dart';
import 'package:noticias_2023/databases/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/article_model.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  // Constructor que recibe un objeto Article
  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    // Widget Card que representa la tarjeta de noticias
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sección para mostrar la imagen de la noticia
          if (article.urlToImage != null && article.urlToImage.isNotEmpty)
            // Utiliza CachedNetworkImage para cargar la imagen desde la URL
            CachedNetworkImage(
              imageUrl: article.urlToImage,
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
            )
          else
            // Si no hay imagen, se muestra una imagen predeterminada
            Image.asset(
              'assets/top_headlines.png',
              fit: BoxFit.contain,
              height: 200,
            ),
          // Sección de detalles de la noticia (título, descripción, enlace y botón de favorito)
          ListTile(
            title: Text(article.title),
            subtitle: Text(article.description),
            onTap: () {
              // Al tocar la tarjeta, se abre la URL de la noticia en el navegador
              _launchURL(article.url);
            },
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Al presionar el botón de favorito, se agrega la noticia a la lista de favoritos
                _addToFavorites(article);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para agregar la noticia a la lista de favoritos
  void _addToFavorites(Article article) {
    DatabaseHelper().insertFavorite(article);
  }

  // Método para abrir la URL de la noticia en el navegador
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
