// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:just66/data/models/graph_point.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:just66/presentation/pages/progress/line_progress.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _SuccessHabitPageState();
}

class _SuccessHabitPageState extends State<ProgressPage> {
  List<bool> toggleButtonStatus = [true, false, false];
  List<int> toggleButtonDays = [7, 30, 365];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Progress",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text("Check your progress here!",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.grey[600],
                    )),
            CustomTitle(title: "Progress"),
            Expanded(
                child: Center(
                    child: StreamBuilder<List<GraphPoint>>(
                        stream: Provider.of<HabitRepository>(context)
                            .getRecordTotalsByDay(toggleButtonDays[index]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          List<GraphPoint> graphPoints = snapshot.data!;
                          return LineProgress(
                            graphPoints: graphPoints,
                          );
                        }))),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  toggleButton("Week", 0),
                  toggleButton("Month", 1),
                  toggleButton("Year", 2),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Expanded toggleButton(String buttonName, int buttonIndex) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(color: Colors.black45, width: 0.5),
          backgroundColor: toggleButtonStatus[buttonIndex]
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.transparent,
          minimumSize: Size(50, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () {
          for (int i = 0; i < toggleButtonStatus.length; i++) {
            toggleButtonStatus[i] = i == buttonIndex;
            index = buttonIndex;
          }
          setState(() {});
        },
        child: Text(buttonName),
      ),
    );
  }
}
