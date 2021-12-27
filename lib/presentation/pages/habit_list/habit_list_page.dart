// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:just66/presentation/utils/constants.dart';
import 'package:just66/presentation/utils/message_helpers.dart';
import 'package:provider/provider.dart';

import '../../../data/models/habit.dart';
import '../habit_list/habit_widget.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _mainLabel(context),
            StreamBuilder<List<Habit>>(
                stream: Provider.of<HabitRepository>(context).getActiveHabits(),
                builder: (context, snapshot) {
                  return HabitListSummaryCard(habits: snapshot.data ?? []);
                }),
            CustomTitle(title: context.messages.currentlyActiveHabits),
            Expanded(child: _habitList()),
          ],
        ),
      ),
    );
  }

  Padding _mainLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.messages.habitListPageTitle(Constants.NUMBER_OF_HABITS),
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            Text(
              context.messages
                  .habitListPageSubtitle(Constants.NUMBER_OF_HABITS),
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _habitList() {
    return StreamBuilder<List<Habit>>(
      stream: Provider.of<HabitRepository>(context).getActiveHabits(),
      builder: (ctx, habitsSnapshot) {
        if (!habitsSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (habitsSnapshot.data!.isEmpty) {
          return Center(child: Text(context.messages.noHabitsMessage));
        } else {
          final habits = habitsSnapshot.data!;
          return ListView.builder(
              itemCount: habits.length + 1,
              itemBuilder: (context, index) {
                if (index == habits.length) {
                  return Padding(padding: EdgeInsets.only(bottom: 32));
                }
                return HabitWidget(habit: habits[index]);
              });
        }
      },
    );
  }
}
