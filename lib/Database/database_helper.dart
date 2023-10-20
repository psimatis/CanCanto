import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'phrase.dart';

class DatabaseHelper {
  static final _databaseName = "cancanto.db";
  static final _databaseVersion = 1;

  static final table = 'notes';

  static final columnId = '_id';
  static final columnCantonese = 'cantonese';
  static final columnEnglish = 'english';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Lazily instantiate the database if unavailable
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database, creating if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE $table (
             $columnId INTEGER PRIMARY KEY,
             $columnCantonese TEXT NOT NULL,
             $columnEnglish TEXT NOT NULL
           )
           ''');
  }

  // Insert a note into the database
  Future<int> insert(Phrase phrase) async {
    Database db = await instance.database;
    return await db.insert(table, phrase.toMap());
  }

  // Retrieve all notes from the database
  Future<List<Phrase>> getAllNotes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Phrase.fromMap(maps[i]);
    });
  }

  // Update a note in the database
  Future<int> update(Phrase Phrase) async {
    Database db = await instance.database;
    return await db.update(table, Phrase.toMap(),
        where: '$columnId = ?', whereArgs: [Phrase.id]);
  }

  // Delete a note from the database
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}