import 'package:flutter/material.dart';
import 'package:noticias_2023/providers/articles_provider.dart';
import 'package:noticias_2023/widgets/card_swiper.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Colocamos la instancia de ArticlesProvider
    final articlesProvider = Provider.of<ArticlesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
        title: const Center(
          child: Text('Noticias de última hora'),
        ),
      ),
      body: Column(
        children: [
          CardSwiper(
            articles: articlesProvider.onDisplayArticles,
          ),
          // MovieSlider(
          //   movies: moviesProvider.popularMovies,
          // )
        ],
      ),
    );
  }
}
