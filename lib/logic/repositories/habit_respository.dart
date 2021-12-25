import 'package:just66/data/models/graph_point.dart';

import '../../data/models/habit.dart';
import '../../data/models/record.dart';

abstract class HabitRepository {
  Future<int> createHabit(Habit habit);

  Future<int> deleteHabit(int id);

  Stream<List<Habit>> getCompletedHabits();

  Stream<List<Habit>> getActiveHabits();

  Stream<List<Record>> getRecordsForHabit(int habitId);

  Future<int> createRecord(Record record);

  Future<int> deleteRecord(int id);

  Future<void> completeHabit(int habitId);

  Stream<List<GraphPoint>> getRecordTotalsByDay(int range);
}
