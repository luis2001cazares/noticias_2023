import 'package:flutter/material.dart';
import 'screens/news_screen.dart';
import 'providers/news_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsScreen(
        newsProvider: NewsProvider(apiKey: '0f8396e404bd43c6b3e8a2392275809f', country: 'mx'),
      ),
    );
  }
}

