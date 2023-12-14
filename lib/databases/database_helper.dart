// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/article_model.dart';

class DatabaseHelper {
  // Instancia de la base de datos
  Database? _database;

  // Getter para obtener la instancia de la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Inicializa la base de datos y devuelve la instancia
  Future<Database> initDatabase() async {
    // Obtiene la ruta de la base de datos
    String path = join(await getDatabasesPath(), 'favorites.db');
    
    // Abre la base de datos (creándola si no existe) con versión 1
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // Método para crear la tabla 'favorites' en la base de datos
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

  // Método para insertar una noticia en la tabla 'favorites'
  Future<void> insertFavorite(Article article) async {
    final Database db = await database;
    
    // Inserta el artículo en la tabla 'favorites'
    await db.insert(
      'favorites',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para eliminar una noticia de la tabla 'favorites'
  Future<void> removeFavorite(Article article) async {
    final Database db = await database;
    
    // Elimina el artículo de la tabla 'favorites' donde la URL coincide
    await db.delete(
      'favorites',
      where: 'url = ?',
      whereArgs: [article.url],
    );
  }

  // Método para obtener todas las noticias favoritas de la tabla 'favorites'
  Future<List<Article>> getFavorites() async {
    final Database db = await database;
    
    // Consulta todas las filas de la tabla 'favorites'
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    
    // Convierte los resultados en una lista de objetos Article
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

