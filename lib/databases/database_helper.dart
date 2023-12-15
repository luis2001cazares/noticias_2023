import 'package:noticias_2023/models/article_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

    final List<Map<String, dynamic>> existingArticle = await db.query(
      'favorites',
      where: 'url = ?',
      whereArgs: [article.url],
    );

    if (existingArticle.isEmpty) {
      await db.insert(
        'favorites',
        article.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> removeFavorite(Article article) async {
    final Database db = await database;

    await db.delete(
      'favorites',
      where: 'url = ?',
      whereArgs: [article.url],
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
        isFavorite: true, // Marcado como favorito al obtenerlo de la base de datos
      );
    });
  }
}
