// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:just66/data/models/habit.dart';
import 'package:just66/presentation/utils/datetime_helpers.dart';

class Record extends Equatable {
  final int? id;
  final DateTime recordDate;
  final int habitId;

  Record({
    this.id,
    required this.recordDate,
    required this.habitId,
  });

  @override
  List<Object?> get props => [id, recordDate, habitId];

  Map<String, dynamic> toMap() {
    return {
      'record_id': id,
      'record_date': recordDate.toYMD(),
      'habit_fid': habitId,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      id: map['record_id']?.toInt(),
      recordDate: DateTimeHelpers.fromYMD(map['record_date']),
      habitId: map['habit_fid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Record.fromJson(String source) => Record.fromMap(json.decode(source));
}
