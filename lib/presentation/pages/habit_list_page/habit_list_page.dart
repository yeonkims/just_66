// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../../../data/models/habit.dart';
import '../habit_list_page/habit_widget.dart';
import 'habit_list_summary_card.dart';

class HabitListPage extends StatelessWidget {
  HabitListPage({Key? key}) : super(key: key);

  final List<Habit> habits = [
    Habit(
      title: "집 청소 상태 유지하기",
      days: 15,
      completed: true,
    ),
    Habit(
      title: "책 매일 읽기",
      days: 20,
      completed: false,
    ),
    Habit(
      title: "머리 말리고 자기",
      days: 3,
      completed: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HabitListSummaryCard(),
          CustomTitle(title: "My habit list"),
          _habitList(),
        ],
      ),
    );
  }

  Expanded _habitList() {
    return Expanded(
      child: ListView.builder(
          itemCount: habits.length,
          itemBuilder: (context, index) => HabitWidget(habit: habits[index])),
    );
  }
}
