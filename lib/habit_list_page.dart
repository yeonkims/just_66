import 'package:flutter/material.dart';

import 'habit.dart';
import 'habit_widget.dart';

class HabitListPage extends StatelessWidget {
  HabitListPage({Key? key}) : super(key: key);

  final List<Habit> habits = [
    Habit(title: "집 청소 상태 유지하기", days: 15),
    Habit(title: "책 매일 읽기", days: 20),
    Habit(title: "머리 말리고 자기", days: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) => HabitWidget(habit: habits[index]));
  }
}
