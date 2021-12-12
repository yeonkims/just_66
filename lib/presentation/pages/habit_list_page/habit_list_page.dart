// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../../../data/models/habit.dart';
import '../habit_list_page/habit_widget.dart';

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
          SizedBox(
            height: 140,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(24.0)),
              ),
              color: Colors.blue[100],
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 4.0, bottom: 4.0),
                          child: Text(
                            "Good Morning!",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                            "오늘 당신이 채운 당신의 습관의 물입니다. 100%를 채울때까지 열심히 노력해 보십시오. 화이팅...!"),
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: LiquidCircularProgressIndicator(
                        value: 0.8,
                        backgroundColor: Colors
                            .white, // Defaults to the current Theme's backgroundColor.
                        borderColor: Colors.lightBlue,
                        borderWidth: 2.5,
                        direction: Axis
                            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text(
                          "80%",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 24.0, top: 20.0),
              child: Text(
                "My habit list",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) =>
                    HabitWidget(habit: habits[index])),
          ),
        ],
      ),
    );
  }
}
