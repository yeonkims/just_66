import 'package:just66/data/models/habit.dart';

abstract class HabitRepository {
  Future<int> createHabit(Habit habit);

  Future<int> deleteHabit(int id);

  Stream<List<Habit>> getAllHabits();
}
