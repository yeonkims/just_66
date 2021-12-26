// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/presentation/utils/datetime_helpers.dart';

class Habit extends Equatable {
  final int? id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;

  final Record? todaysRecord;
  final int recordedDays;

  bool get completed => endDate != null;

  bool isTodayRecorded() {
    return todaysRecord != null;
  }

  Habit({
    this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    this.todaysRecord,
    this.recordedDays = 0,
  });

  @override
  List<Object?> get props => [id, title, startDate, endDate];

  Map<String, dynamic> toMap() {
    return {
      'habit_id': id,
      'title': title,
      'start_date': startDate.toYMD(),
      'end_date': endDate?.toYMD(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['habit_id']?.toInt(),
      title: map['title'] ?? '',
      startDate: DateTimeHelpers.fromYMD(map['start_date']),
      endDate: map['end_date'] == null
          ? null
          : DateTimeHelpers.fromYMD(map['end_date']),
      todaysRecord: map['record_id'] == null ? null : Record.fromMap(map),
      recordedDays: map['recorded_days'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));
}
