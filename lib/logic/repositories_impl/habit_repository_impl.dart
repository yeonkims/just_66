import 'dart:math';

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
    return db.executeAndTrigger([
      "habit"
    ], "UPDATE habit SET end_date = '${DateTime.now().toYMD()}' WHERE habit_id = $habitId");
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

  @override
  Future<void> deleteAll() async {
    await db.executeAndTrigger(["record", "habit"], "DELETE FROM habit");
    await db.executeAndTrigger(["record", "habit"], "DELETE FROM record");
  }

  @override
  Future<void> createTestData() async {
    print(
        "-------- CREATING TEST DATA! dont't forget to comment the line for next time :)");
    await _createFakeHabit("Wake up by 7AM", 66);
    await _createFakeHabit("Cold Shower", 66);
    await _createFakeHabit("Piano", 56);
    await _createFakeHabit("Run 5K", 30);
    await _createFakeHabit("Read 10 pages", 12);
  }

  Future<void> _createFakeHabit(String name, int numberOfRecords) async {
    int totalNumberOfDays = (numberOfRecords * 1.5).toInt();
    Habit newHabit = Habit(
      title: name,
      startDate: DateTime.now().subtract(
        Duration(
          days: totalNumberOfDays - 1,
        ),
      ),
    );
    int newHabitId = await createHabit(newHabit);
    List<int> allPossibleDays =
        List<int>.generate(totalNumberOfDays, (index) => index);

    allPossibleDays.shuffle();

    for (int j = 0; j <= numberOfRecords; j++) {
      Record newRecord = Record(
        recordDate: DateTime.now().subtract(
          Duration(days: allPossibleDays[j]),
        ),
        habitId: newHabitId,
      );
      await createRecord(newRecord);
    }

    if (numberOfRecords >= 66) {
      await completeHabit(newHabitId);
    }
  }
}
