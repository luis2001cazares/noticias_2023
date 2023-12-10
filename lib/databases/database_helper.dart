// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/article_model.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        urlToImage TEXT,
        url TEXT,
        source TEXT,
        author TEXT,
        publishedAt TEXT,
        content TEXT
      )
    ''');
  }

  Future<void> insertFavorite(Article article) async {
    final Database db = await database;
    await db.insert(
      'favorites',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Article>> getFavorites() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return Article(
        source: maps[i]['source'] ?? '',
        author: maps[i]['author'] ?? '',
        title: maps[i]['title'] ?? '',
        description: maps[i]['description'] ?? '',
        url: maps[i]['url'] ?? '',
        urlToImage: maps[i]['urlToImage'] ?? '',
        publishedAt: maps[i]['publishedAt'] ?? '',
        content: maps[i]['content'] ?? '',
      );
    });
  }
}




