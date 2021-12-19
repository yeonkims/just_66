import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  final int dbVersion = 2;

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
    Database theDB = await openDatabase(path,
        version: dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    print("_onCreate $version");
    for (int v in List.generate(version, (i) => i + 1)) {
      _makeDBChange(db, v);
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("_onUpgrade $oldVersion -> $newVersion");
    for (int v = oldVersion + 1; v <= newVersion; v++) {
      _makeDBChange(db, v);
    }
  }

  void _makeDBChange(Database db, int version) async {
    print("_makeDBChange $version");
    if (version == 1) {
      await db.execute(
          "CREATE TABLE habit(habit_id INTEGER PRIMARY KEY, title TEXT, start_date TEXT, completed BOOLEAN)");
    }
    if (version == 2) {
      await db.execute(
          "CREATE TABLE record(record_id INTEGER PRIMARY KEY, record_date TEXT, habit_fid INTEGER REFERENCES habit(habit_id) ON UPDATE CASCADE ON DELETE CASCADE)");
    }
  }
}
