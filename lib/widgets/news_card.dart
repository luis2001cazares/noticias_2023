import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Importa la biblioteca cached_network_image.
import '../models/article_model.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Utiliza CachedNetworkImage con una imagen de respaldo.
          if (article.urlToImage != null && article.urlToImage.isNotEmpty)
            CachedNetworkImage(
              imageUrl: article.urlToImage,
              placeholder: (context, url) => Image.asset(
                'assets/top_headlines.png', // Imagen de respaldo desde activos locales.
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
            Image.asset(
              'assets/top_headlines.png', // Imagen de respaldo desde activos locales.
              fit: BoxFit.contain,
              height: 200,
            ),
          ListTile(
            title: Text(article.title),
            subtitle: Text(article.description),
            onTap: () {
              _launchURL(article.url);
            },
          ),
        ],
      ),
    );
  }

  // Función para abrir la URL en un navegador externo.
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}



