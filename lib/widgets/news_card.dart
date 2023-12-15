import 'package:flutter/material.dart';
import 'package:noticias_2023/databases/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/article_model.dart';

class NewsCard extends StatefulWidget {
  final Article article;

  NewsCard({required this.article});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.article.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.article.urlToImage != null &&
              widget.article.urlToImage.isNotEmpty)
            CachedNetworkImage(
              imageUrl: widget.article.urlToImage,
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
            Image.asset(
              'assets/top_headlines.png',
              fit: BoxFit.contain,
              height: 200,
            ),
          ListTile(
            title: Text(widget.article.title),
            subtitle: Text(widget.article.description),
            onTap: () {
              _launchURL(widget.article.url);
            },
            trailing: IconButton(
              icon: isFavorite
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
              onPressed: isFavorite
                  ? null
                  : () {
                      _toggleFavoriteStatus(context);
                    },
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavoriteStatus(BuildContext context) {
    DatabaseHelper().insertFavorite(widget.article);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to favorites'),
      ),
    );

    setState(() {
      isFavorite = true;
    });

    widget.article.isFavorite = true;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
