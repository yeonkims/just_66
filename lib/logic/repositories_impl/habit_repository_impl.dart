import '../../data/models/habit.dart';
import '../../data/models/record.dart';
import '../repositories/habit_respository.dart';
import 'package:sqlbrite/sqlbrite.dart';

class HabitRepositoryImpl extends HabitRepository {
  BriteDatabase db;

  HabitRepositoryImpl({required this.db});

  @override
  Future<int> createHabit(Habit habit) {
    return db.insert("habit", habit.toMap());
  }

  @override
  Future<int> deleteHabit(int id) {
    return db.delete("habit", where: "habit_id = $id");
  }

  @override
  Stream<List<Habit>> getAllHabits() {
    return db.createRawQuery(["habit", "record"], """
    SELECT *, 
    (SELECT COUNT(record_id) FROM record r2 WHERE habit_id = r2.habit_fid) AS recorded_days
    FROM habit LEFT JOIN record r1 ON habit_id = r1.habit_fid AND DATE(record_date) = DATE('now')
    """).mapToList((habitMap) {
      return Habit.fromMap(habitMap);
    });
  }

  @override
  Future<int> createRecord(Record record) {
    return db.insert("record", record.toMap());
  }

  @override
  Future<int> deleteRecord(int id) {
    return db.delete("record", where: "record_id = $id");
  }
}
