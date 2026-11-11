import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../models/design.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('meme_designs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE designs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        text TEXT NOT NULL,
        bottomText TEXT,
        backgroundColorValue INTEGER NOT NULL,
        textColorValue INTEGER NOT NULL,
        fontSize REAL NOT NULL
      )
    ''');

    // Insert some default mock data for demonstration
    await db.insert('designs', {
      'title': 'First meme',
      'text': 'When code works on first try',
      'bottomText': 'Surprised Pikachu',
      'backgroundColorValue': 0xFF673AB7,
      'textColorValue': 0xFFFFFFFF,
      'fontSize': 28.0,
    });
    await db.insert('designs', {
      'title': 'Birthday post',
      'text': 'Happy Birthday!',
      'bottomText': 'Have a great year ahead',
      'backgroundColorValue': 0xFFE91E63,
      'textColorValue': 0xFFFFFFFF,
      'fontSize': 32.0,
    });
  }

  // Controller for real-time stream updates (Week 16 syllabus requirement)
  final _designsStreamController = StreamController<List<Design>>.broadcast();

  Stream<List<Design>> get designsStream async* {
    yield await getDesigns();
    yield* _designsStreamController.stream;
  }

  Future<void> _notifyChanges() async {
    final designs = await getDesigns();
    _designsStreamController.add(designs);
  }

  // CREATE: Insert new design
  Future<int> insertDesign(Design design) async {
    final db = await instance.database;
    final id = await db.insert('designs', design.toMap());
    await _notifyChanges();
    return id;
  }

  // READ: Get all designs
  Future<List<Design>> getDesigns() async {
    final db = await instance.database;
    final result = await db.query('designs', orderBy: 'id DESC');
    return result.map((json) => Design.fromMap(json)).toList();
  }

  // UPDATE: Update existing design
  Future<int> updateDesign(Design design) async {
    final db = await instance.database;
    final count = await db.update(
      'designs',
      design.toMap(),
      where: 'id = ?',
      whereArgs: [design.id],
    );
    await _notifyChanges();
    return count;
  }

  // DELETE: Remove design by id
  Future<int> deleteDesign(int id) async {
    final db = await instance.database;
    final count = await db.delete(
      'designs',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _notifyChanges();
    return count;
  }

  // SEARCH: Search designs by title or text
  Future<List<Design>> searchDesigns(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'designs',
      where: 'title LIKE ? OR text LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
    return result.map((json) => Design.fromMap(json)).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
    _designsStreamController.close();
  }
}
