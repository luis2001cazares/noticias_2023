import 'package:flutter/material.dart';
import 'package:noticias_2023/providers/articles_provider.dart';
import 'package:noticias_2023/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la instancia de ArticlesProvider
    final articlesProvider = Provider.of<ArticlesProvider>(context);

    // Llamamos a la función para cargar los datos de noticias de última hora
    articlesProvider.getOnDisplayArticles();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Implementa la búsqueda de noticias aquí
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
        title: const Center(
          child: Text('Noticias de última hora'),
        ),
      ),
      body: Column(
        children: [
          // Verificamos si hay datos para mostrar en el CardSwiper
          articlesProvider.onDisplayArticles.isNotEmpty
              ? CardSwiper(
                  articles: articlesProvider.onDisplayArticles,
                )
              : const Center(child: CircularProgressIndicator()),

          // Puedes agregar otros widgets o componentes aquí, como una lista de noticias, etc.
        ],
      ),
    );
  }
}

