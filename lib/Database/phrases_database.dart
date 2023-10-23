import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'phrase.dart';

class PhrasesDatabase {
  static final PhrasesDatabase instance = PhrasesDatabase._init();

  static Database? _database;

  PhrasesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('test.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    
    await db.execute('''
CREATE TABLE $tablePhrases ( 
  ${PhraseFields.id} $idType, 
  ${PhraseFields.cantonese} $textType,
  ${PhraseFields.english} $textType
  )
''');
  }

  Future<Phrase> create(Phrase phrase) async {
    final db = await instance.database;
    
    final id = await db.insert(tablePhrases, phrase.toJson());
    return phrase.copy(id: id);
  }

  Future<Phrase> readNote(int id) async {
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

  Future<List<Phrase>> readAllNotes() async {
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
}