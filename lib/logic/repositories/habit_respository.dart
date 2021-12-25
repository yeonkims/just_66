import '../../data/models/habit.dart';
import '../../data/models/record.dart';

abstract class HabitRepository {
  Future<int> createHabit(Habit habit);

  Future<int> deleteHabit(int id);

  Stream<List<Habit>> getAllHabits();

  Stream<List<Record>> getRecordsForHabit(int habitId);

  Future<int> createRecord(Record record);

  Future<int> deleteRecord(int id);
}
