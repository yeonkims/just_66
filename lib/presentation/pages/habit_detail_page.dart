// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:provider/provider.dart';

import '../../data/models/habit.dart';

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
        decoration: _backgroundGradient(context),
        child: SafeArea(
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    _progressBar(context),
                    _subTitle(context),
                    CustomTitle(title: "Breakdown"),
                    _breakdownGrid()
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

  BoxDecoration _backgroundGradient(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.white,
          Theme.of(context).primaryColor.withOpacity(0.3)
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
            Provider.of<HabitRepository>(context, listen: false)
                .deleteHabit(habit.id!);
            Navigator.pop(context);
          },
          icon: FaIcon(FontAwesomeIcons.trashAlt),
        ),
      ],
    );
  }

  Padding _breakdownGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Color.fromRGBO(80, 80, 80, 1),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index % 3 == 0
                          ? Colors.red
                          : Theme.of(context).primaryColor),
                ),
              ),
              itemCount: habit.recordedDays,
            ),
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
            "${habit.recordedDays}/66\ndays",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[350],
              value: habit.recordedDays / 66,
              strokeWidth: 6.5,
            ),
          ),
        ],
      ),
    );
  }
}
