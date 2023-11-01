import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:noticias_2023/models/article.dart';

class CardSwiper extends StatelessWidget {
  final List<Article> articles;
  const CardSwiper({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: articles.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          final article = articles[index];
          //print(movie.posterPath);
          //7print(movie.fullPosterImg);
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: article),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(article.fullPosterImg),
              ),
            ),
          );
        },
      ),
    );
  }
}
