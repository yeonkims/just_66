// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/presentation/utils/datetime_helpers.dart';

class Habit extends Equatable {
  final int? id;
  final String title;
  final DateTime startDate;
  final bool completed;

  final Record? todaysRecord;
  final int recordedDays;

  bool isTodayRecorded() {
    return todaysRecord != null;
  }

  Habit({
    this.id,
    required this.title,
    required this.completed,
    required this.startDate,
    this.todaysRecord,
    this.recordedDays = 0,
  });

  @override
  List<Object?> get props => [id, title, startDate, completed];

  Map<String, dynamic> toMap() {
    return {
      'habit_id': id,
      'title': title,
      'start_date': startDate.toYMD(),
      'completed': completed ? 1 : 0,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['habit_id']?.toInt(),
      title: map['title'] ?? '',
      startDate: DateTimeHelpers.fromYMD(map['start_date']),
      completed: map['completed'] == 1,
      todaysRecord: map['record_id'] == null ? null : Record.fromMap(map),
      recordedDays: map['recorded_days'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));
}
