import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        author TEXT,
        rating INTEGER,
        read INTEGER
      )
    ''');
  }

  Future<int> insertBook(Map<String, dynamic> book) async {
    Database db = await database;
    return await db.insert('books', book);
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    Database db = await database;
    return await db.query('books');
  }

  Future<int> updateBook(Map<String, dynamic> book, int id) async {
    Database db = await database;
    return await db.update('books', book, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBook(int id) async {
    Database db = await database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}
