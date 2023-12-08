// news_screen.dart
import 'package:flutter/material.dart';
import 'package:noticias_2023/models/article_model.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';
import 'search_screen.dart';

class NewsScreen extends StatefulWidget {
  final NewsProvider newsProvider;

  NewsScreen({required this.newsProvider});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String selectedCountry = 'us'; // Valor predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking news'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(newsProvider: widget.newsProvider),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCountry,
            onChanged: (String? newValue) {
              setState(() {
                selectedCountry = newValue!;
                widget.newsProvider.updateCountry(selectedCountry);
              });
            },
            items: <String>['us', 'mx', 'ca', 'gb', 'fr', 'de']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.toUpperCase()),
              );
            }).toList(),
          ),
          FutureBuilder(
            future: widget.newsProvider.getTopHeadlines(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final List<Article> articles = snapshot.data as List<Article>;
                return Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(article: articles[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
