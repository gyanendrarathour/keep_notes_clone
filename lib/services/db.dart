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
    await db.execute('''CREATE TABLE Notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pin BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdTime TEXT NOT NULL
    )''');
  }

  Future<bool?> insertEntry() async {
    final db = await instance.database;
    await db!.insert('notes', {
      'pin': 0,
      'title': 'This is my Title',
      'content': 'This is my note content',
      'createdTime': '8th Oct 2022'
    });
    return true;
  }

  // read the data from database
  Future<String> readAllNotes() async {
    final db = await instance.database;
    final orderBy = 'createdTime ASC';
    final queryResult = await db!.query('Notes', orderBy: orderBy);
    print(queryResult);
    return 'Successfull';
  }

  // read one entry
  Future<String?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!
        .query('Notes', columns: ['title'], where: 'id=?', whereArgs: [id]);
    print(map);
  }

  // update entry
  Future updateNote(int id) async {
    final db = await instance.database;
    return await db!.update(
        'Notes', {'title': 'This is a updated title by gyan'},
        where: 'id=?', whereArgs: [id]);
  }

  // delete entry
  Future deleteNote(int id) async {
    final db = await instance.database;
    return await db!.delete('Notes', where: 'id=?', whereArgs: [id]);
  }
}
