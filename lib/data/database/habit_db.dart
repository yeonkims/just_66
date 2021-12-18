import 'package:just66/data/models/habit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

class HabitDB {
  static Database? _db;

  static final HabitDB _singleton = new HabitDB._internal();

  factory HabitDB() {
    return _singleton;
  }

  HabitDB._internal() {
    initDb().then((resDB) => _db = resDB);
  }

  Future<Database> get db async {
    _db = _db ?? await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    Database theDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE habit(habit_id INTEGER PRIMARY KEY, title TEXT, start_date TEXT, completed BOOLEAN)");
  }

  Future<int> createHabit(Habit habit) async {
    return (await db).insert("habit", habit.toMap());
  }

  Future<int> deleteHabit(int id) async {
    return (await db).delete("habit", where: "habit_id = $id");
  }

  Future<List<Habit>> getAllHabits() async {
    final listOfJson = await (await db).query("habit");
    return listOfJson.map((habitMap) {
      return Habit.fromMap(habitMap);
    }).toList();
  }
}
