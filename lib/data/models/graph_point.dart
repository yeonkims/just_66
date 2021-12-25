// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:just66/data/models/habit.dart';
import 'package:just66/presentation/utils/datetime_helpers.dart';

class GraphPoint extends Equatable {
  final DateTime recordDate;
  final int totalRecords;

  GraphPoint({
    required this.recordDate,
    required this.totalRecords,
  });

  @override
  List<Object?> get props => [recordDate, totalRecords];

  factory GraphPoint.fromMap(Map<String, dynamic> map) {
    return GraphPoint(
      totalRecords: map['total_records'],
      recordDate: DateTimeHelpers.fromYMD(map['record_date']),
    );
  }

  factory GraphPoint.fromJson(String source) =>
      GraphPoint.fromMap(json.decode(source));

  @override
  String toString() => 'GP(${recordDate.toYMD()}, $totalRecords)';
}
