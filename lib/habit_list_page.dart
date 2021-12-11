import 'package:flutter/material.dart';

import 'habit.dart';
import 'habit_widget.dart';

class HabitListPage extends StatelessWidget {
  const HabitListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HabitWidget(habit: Habit(title: "집 청소 후 상태 유지하기", days: 15)),
        HabitWidget(habit: Habit(title: "책 매일 읽기", days: 20)),
      ],
    );
  }
}
