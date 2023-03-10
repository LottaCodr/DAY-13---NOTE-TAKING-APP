import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'note.dart';

class DatabaseHelper {
  static const databaseName = "NotesDatabase.db";
  static const databaseVersion = 1;

  static const table = "Notes";
  static const columnId = "_id";
  static const columnTitle = "_title";
  static const columnContent = "_content";

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnContent TEXT NOT NULL)
    ''');
  }

  Future<int> insert(Note note) async {
    Database db = await database;
    return await db.insert(table, note.toMap());
  }

  Future<List<Note>> getAllNotes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        content: maps[i][columnContent],
      );
    });
  }

  Future<int> delete(Note note) async {
    Database db = await database;
    return db.delete(table, where: "$columnId = ?", whereArgs: [note.id]);
  }

  Future<int> update(Note note) async {
    Database db = await database;
    return db.update(table, note.toMap(), where: "$columnId =?", whereArgs: [note.id]);
  }
}
