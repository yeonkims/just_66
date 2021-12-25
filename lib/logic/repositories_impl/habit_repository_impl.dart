import 'package:just66/data/models/graph_point.dart';
import 'package:just66/presentation/utils/datetime_helpers.dart';

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

  Stream<List<Habit>> getAllHabits() {
    return db.createRawQuery(["habit", "record"], """
    SELECT *, 
    (SELECT COUNT(record_id) FROM record r2 WHERE habit_id = r2.habit_fid) AS recorded_days
    FROM habit LEFT JOIN record r1 ON habit_id = r1.habit_fid AND DATE(record_date) = '${DateTime.now().toYMD()}'
    """).mapToList((habitMap) {
      return Habit.fromMap(habitMap);
    }).asBroadcastStream();
  }

  @override
  Future<int> createRecord(Record record) {
    return db.insert("record", record.toMap());
  }

  @override
  Future<int> deleteRecord(int id) {
    return db.delete("record", where: "record_id = $id");
  }

  @override
  Stream<List<Record>> getRecordsForHabit(int habitId) {
    return db.createRawQuery([
      "record",
      "habit"
    ], "SELECT * FROM record WHERE habit_fid = $habitId").mapToList(
        (recordMap) {
      return Record.fromMap(recordMap);
    }).asBroadcastStream();
  }

  @override
  Stream<List<Habit>> getActiveHabits() {
    return getAllHabits().map((allHabits) {
      return allHabits.where((anyHabit) {
        return !anyHabit.completed;
      }).toList();
    });
  }

  @override
  Stream<List<Habit>> getCompletedHabits() {
    return getAllHabits().map((allHabits) {
      return allHabits.where((anyHabit) {
        return anyHabit.completed;
      }).toList();
    });
  }

  @override
  Future<void> completeHabit(int habitId) {
    return db.executeAndTrigger(
        ["habit"], "UPDATE habit SET completed = 1 WHERE habit_id = $habitId");
  }

  @override
  Stream<List<GraphPoint>> getRecordTotalsByDay(int range) {
    DateTime endRange = DateTime.now().subtract(Duration(days: range));
    return db.createRawQuery([
      "record",
      "habit"
    ], "SELECT COUNT(*) as 'total_records', record_date FROM record WHERE '${endRange.toYMD()}' < record_date GROUP BY record_date").mapToList(
        (map) {
      return GraphPoint.fromMap(map);
    }).map((graphPoints) {
      List<GraphPoint> fullGraphPoints = [];
      for (int i = range - 1; i >= 0; i--) {
        DateTime rangeDate = DateTime.now().subtract(Duration(days: i));
        bool hasGraphPoint = graphPoints.any((existingGraphPoint) {
          return rangeDate.toYMD() == existingGraphPoint.recordDate.toYMD();
        });
        if (!hasGraphPoint) {
          fullGraphPoints
              .add(GraphPoint(recordDate: rangeDate, totalRecords: 0));
        } else {
          fullGraphPoints.add(graphPoints.firstWhere((existingGraphPoint) {
            return rangeDate.toYMD() == existingGraphPoint.recordDate.toYMD();
          }));
        }
      }
      return fullGraphPoints;
    }).asBroadcastStream();
  }
}
