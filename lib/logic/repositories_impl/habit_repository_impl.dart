import 'package:just66/data/models/habit.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:sqlbrite/sqlbrite.dart';

class HabitRepositoryImpl extends HabitRepository {
  BriteDatabase db;

  HabitRepositoryImpl({required this.db});

  @override
  Future<int> createHabit(Habit habit) async {
    return db.insert("habit", habit.toMap());
  }

  @override
  Future<int> deleteHabit(int id) async {
    return db.delete("habit", where: "habit_id = $id");
  }

  @override
  Stream<List<Habit>> getAllHabits() {
    return db.createQuery("habit").mapToList((habitMap) {
      return Habit.fromMap(habitMap);
    });
  }
}
