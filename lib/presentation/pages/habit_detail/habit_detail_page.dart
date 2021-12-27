// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, iterable_contains_unrelated_type

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:just66/presentation/extra_widgets/pop_in_transition.dart';
import 'package:just66/presentation/extra_widgets/yes_no_dialog.dart';
import 'package:just66/presentation/utils/constants.dart';
import 'package:just66/presentation/utils/datetime_helpers.dart';
import 'package:just66/presentation/utils/message_helpers.dart';
import 'package:provider/provider.dart';

import '../../../data/models/habit.dart';

class HabitDetailPage extends StatelessWidget {
  final Habit habit;

  const HabitDetailPage({
    required this.habit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: SafeArea(
          child: Center(
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    _progressBar(context),
                    _subTitle(context),
                    _habitDuration(context),
                    CustomTitle(title: context.messages.breakdown),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          _breakdownLegend(context,
                              color: Theme.of(context).primaryColor,
                              message: context.messages.successfulDayTip),
                          _breakdownLegend(context,
                              color: Colors.red,
                              message: context.messages.unsuccessfulDayTip),
                        ],
                      ),
                    ),
                    _breakdownGrid(context),
                  ],
                ),
                _headerButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _breakdownLegend(
    BuildContext context, {
    required Color color,
    required String message,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        Flexible(
          child: Text(
            " - $message",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: color,
                  fontStyle: FontStyle.italic,
                ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Padding _habitDuration(BuildContext context) {
    String dateFormat = "yyyy/M/d";
    String endDate =
        habit.endDate?.format(dateFormat) ?? context.messages.today;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${habit.startDate.format(dateFormat)} - $endDate",
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Row _headerButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(),
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return PopInTransition(
                    child: YesNoDialog(
                      title: context.messages.deleteHabitDialogTitle,
                      hint: context.messages.deleteHabitDialogHint(habit.title),
                      onYes: () {
                        Provider.of<HabitRepository>(context, listen: false)
                            .deleteHabit(habit.id!);
                        Navigator.pop(context);
                      },
                    ),
                  );
                });
          },
          icon: FaIcon(FontAwesomeIcons.trashAlt),
        ),
      ],
    );
  }

  Widget _breakdownGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Color.fromRGBO(80, 80, 80, 1),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: StreamBuilder<List<Record>>(
                stream: Provider.of<HabitRepository>(context)
                    .getRecordsForHabit(habit.id!),
                builder: (context, snapshot) {
                  final records = snapshot.data ?? [];
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 11),
                    itemBuilder: (context, index) {
                      final currentDay =
                          habit.startDate.add(Duration(days: index));
                      final currentDayHasRecord = records
                          .map((record) => record.recordDate)
                          .toList()
                          .any((recordDate) {
                        return currentDay.toYMD() == recordDate.toYMD();
                      });
                      final currentDayIsToday =
                          currentDay.toYMD() == DateTime.now().toYMD();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: !currentDayHasRecord
                                  ? (currentDayIsToday
                                      ? Colors.white
                                      : Colors.red)
                                  : Theme.of(context).primaryColor),
                        ),
                      );
                    },
                    itemCount:
                        DateTime.now().difference(habit.startDate).inDays + 1,
                  );
                }),
          ),
        ),
      ),
    );
  }

  Hero _subTitle(BuildContext context) {
    return Hero(
      tag: habit,
      child: Text(
        habit.title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Padding _progressBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            context.messages.habitDaysSummary(
                habit.recordedDays, Constants.NUMBER_OF_HABITS),
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[350],
              value: habit.recordedDays / Constants.NUMBER_OF_HABITS,
              strokeWidth: 6.5,
            ),
          ),
        ],
      ),
    );
  }
}
