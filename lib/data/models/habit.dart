import 'dart:convert';

import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  int? id;
  String title;
  DateTime startDate;
  bool completed;

  int days = 10;

  Habit({
    this.id,
    required this.title,
    required this.completed,
    required this.startDate,
  });

  @override
  List<Object?> get props => [id, title, startDate, completed];

  Map<String, dynamic> toMap() {
    return {
      'habit_id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'completed': completed ? 1 : 0,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['habit_id']?.toInt(),
      title: map['title'] ?? '',
      startDate: DateTime.parse(map['start_date']),
      completed: map['completed'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));
}
