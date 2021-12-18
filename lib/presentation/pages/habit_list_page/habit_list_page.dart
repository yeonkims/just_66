// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../../../data/models/habit.dart';
import '../habit_list_page/habit_widget.dart';
import 'habit_list_summary_card.dart';

class HabitListPage extends StatefulWidget {
  HabitListPage({Key? key}) : super(key: key);

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HabitListSummaryCard(),
          CustomTitle(title: "My habit list"),
          Expanded(child: _habitList()),
        ],
      ),
    );
  }

  Widget _habitList() {
    return StreamBuilder<List<Habit>>(
      stream: Provider.of<HabitRepository>(context).getAllHabits(),
      builder: (ctx, habitsSnapshot) {
        if (!habitsSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (habitsSnapshot.data!.isEmpty) {
          return Center(
              child: Text("You have no habits yet. Please create one."));
        } else {
          final habits = habitsSnapshot.data!;
          return ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) =>
                  HabitWidget(habit: habits[index]));
        }
      },
    );
  }
}
