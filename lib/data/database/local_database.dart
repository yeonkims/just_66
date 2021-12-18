import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static Database? _db;

  static final LocalDatabase _singleton = new LocalDatabase._internal();

  factory LocalDatabase() {
    return _singleton;
  }

  LocalDatabase._internal() {
    initDb().then((resDatabase) {
      _db = resDatabase;
    });
  }

  Future<Database> get db async {
    _db = _db ?? await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    Database theDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE habit(habit_id INTEGER PRIMARY KEY, title TEXT, start_date TEXT, completed BOOLEAN)");
  }
}
