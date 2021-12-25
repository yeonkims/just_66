// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:just66/data/models/habit.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HabitListSummaryCard extends StatelessWidget {
  const HabitListSummaryCard({
    required this.habits,
    Key? key,
  }) : super(key: key);
  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
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
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Welcome!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                      "The right one is the water of the habit you filled today. "),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: LiquidCircularProgressIndicator(
                  value: _todayCompletedPercentage(),
                  backgroundColor: Colors
                      .white, // Defaults to the current Theme's backgroundColor.
                  borderColor: Colors.lightBlue,
                  borderWidth: 2.5,
                  direction: Axis
                      .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                  center: Text(
                    "${(_todayCompletedPercentage() * 100).toInt()}%",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _todayCompletedPercentage() {
    final completedHabits = habits.where((habit) {
      return habit.isTodayRecorded();
    });
    return habits.isEmpty ? 0 : completedHabits.length / habits.length;
  }
}
