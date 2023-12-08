import 'package:flutter/material.dart';
import 'package:noticias_2023/pages/news_screen.dart';
import 'package:noticias_2023/pages/search_screen.dart';
import 'package:noticias_2023/providers/news_provider.dart';
import 'package:noticias_2023/services/auth_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Abrir la pantalla de home
              Navigator.pushNamed(context, 'home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {
              // Abrir la pantalla de breaking news
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsScreen(
                    newsProvider: NewsProvider(apiKey: '0f8396e404bd43c6b3e8a2392275809f', country: 'us'),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Abrir la pantalla de favoritos
              Navigator.pushNamed(context, 'favoritos');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Abrir la pantalla de búsqueda
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(newsProvider: NewsProvider(apiKey: '0f8396e404bd43c6b3e8a2392275809f', country: 'us')),
                ),
              );
            },
          ),
          // Puedes añadir más iconos y funciones según tus necesidades
        ],
      ),
    );
  }
}
