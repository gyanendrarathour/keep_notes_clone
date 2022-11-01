import 'package:keep_notes_clone/model/myNoteModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('notes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''CREATE TABLE Notes(
      ${NotesImpNames.id} $idType,
      ${NotesImpNames.pin} $boolType,
      ${NotesImpNames.title} $textType,
      ${NotesImpNames.content} $textType,
      ${NotesImpNames.createdTime} $textType
    )''');
  }

  Future<Note?> insertEntry(Note note) async {
    final db = await instance.database;
    final id = await db!.insert(NotesImpNames.tableName, note.toJson());
    return note.copy(id: id);
  }

  // read the data from database
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesImpNames.id} ASC';
    final queryResult =
        await db!.query(NotesImpNames.tableName, orderBy: orderBy);
    // print(queryResult);
    return queryResult.map((json) => Note.fromJson(json)).toList();
  }

  // read one entry
  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!.query(NotesImpNames.tableName,
        columns: NotesImpNames.values,
        where: '${NotesImpNames.id}=?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Note.fromJson(map.first);
    } else {
      return null;
    }
  }

  // update entry
  Future updateNote(Note note) async {
    final db = await instance.database;
    return await db!.update(NotesImpNames.tableName, note.toJson(),
        where: '${NotesImpNames.id}=?', whereArgs: [note.id]);
  }

  // delete entry
  Future deleteNote(Note note) async {
    final db = await instance.database;
    return await db!.delete(NotesImpNames.tableName,
        where: '${NotesImpNames.id}=?', whereArgs: [note.id]);
  }

  // Close Database
  Future closeDB() async {
    final db = await instance.database;
    db!.close();
  }
}
