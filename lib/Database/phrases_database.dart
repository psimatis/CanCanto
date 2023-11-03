import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'phrase.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PhrasesDatabase {
  static final PhrasesDatabase instance = PhrasesDatabase._init();
  static Database? _database;

  PhrasesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('test13.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // final dbPath = await getDatabasesPath();
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);
    print('GOT THE PATH BRO: $path');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE $tablePhrases ( 
  ${PhraseFields.id} $idType, 
  ${PhraseFields.cantonese} $textType,
  ${PhraseFields.english} $textType,
  ${PhraseFields.attempts} $intType,
  ${PhraseFields.successes} $intType,
  ${PhraseFields.comment} $textType
  )
''');
  }

  Future<Phrase> create(Phrase phrase) async {
    final db = await instance.database;
    final id = await db.insert(tablePhrases, phrase.toJson());
    return phrase.copy(id: id);
  }

  Future<bool> checkStatus(PhrasesDatabase phrasesDatabase) async {
    final allPhrases = await phrasesDatabase.readAllPhrases();
    return allPhrases.isEmpty;
  }

  Future<Phrase> readPhrase(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tablePhrases,
      columns: PhraseFields.values,
      where: '${PhraseFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Phrase.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Phrase> getRandomPhrase() async {
    final Database db = await database;
    final count = Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $tablePhrases')) ??
        0;
    final randomOffset = Random().nextInt(count);
    final maps = await db.query(
      tablePhrases,
      columns: PhraseFields.values,
      orderBy: 'RANDOM()',
      limit: 1,
      offset: randomOffset,
    );
    return Phrase.fromJson(maps.first);
  }

  Future<List<Phrase>> readAllPhrases() async {
    final db = await instance.database;
    final result = await db.query(tablePhrases);
    return result.map((json) => Phrase.fromJson(json)).toList();
  }

  Future<int> update(Phrase phrase) async {
    final db = await instance.database;
    return db.update(
      tablePhrases,
      phrase.toJson(),
      where: '${PhraseFields.id} = ?',
      whereArgs: [phrase.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tablePhrases,
      where: '${PhraseFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<String?> exportDatabase() async {
    try {
      // Get the path to the current database file, if available
      final dbPath = await getApplicationDocumentsDirectory();
      final path = join(dbPath.path, 'test13.db');
      final databasePath = path;

      if (databasePath != null) {

        // Generate a new filename for the exported database
        final fileName = 'exported_database.db';

        // Get the path to the downloads folder, if available
        final downloadsDirectory = await getDownloadsDirectory();

        if (downloadsDirectory != null) {

          // Construct the full path for the exported database in the downloads folder
          final exportedFilePath = join(downloadsDirectory.path, fileName);

          // Copy the database file to the downloads folder
          await File(databasePath).copy(exportedFilePath);
          print('EXPORTED BRO $exportedFilePath');
          // Return the path to the exported database
          return exportedFilePath;
        }
      }
    } catch (e) {
      // Handle errors if the export fails
      print('Error exporting database: $e');
      // You might want to throw an exception or handle the error differently
    }
    // Return null if something went wrong
    return null;
  }
}
