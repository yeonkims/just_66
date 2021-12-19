// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation_helpers.dart';
import '../../../data/models/habit.dart';
import '../../extra_widgets/animated_checkbox.dart';
import '../habit_detail_page.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HabitWidget extends StatelessWidget {
  HabitWidget({
    required this.habit,
    Key? key,
  }) : super(key: key);

  final Habit habit;

  final BorderRadius cardRadius = BorderRadius.circular(24);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 2.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.all(0.0),
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: cardRadius),
          child: InkWell(
            borderRadius: cardRadius,
            onTap: () {
              context.openPage(HabitDetailPage(habit: habit));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              child: Row(
                children: [
                  AnimatedCheckbox(
                    checked: habit.isTodayRecorded(),
                    onChanged: (checked) {
                      if (checked) {
                        final newRecord = Record(
                            recordDate: DateTime.now(), habitId: habit.id!);
                        Provider.of<HabitRepository>(context, listen: false)
                            .createRecord(newRecord);
                      } else {
                        Provider.of<HabitRepository>(context, listen: false)
                            .deleteRecord(habit.todaysRecord!.id!);
                      }
                    },
                  ),
                  _habitData(context),
                  _rightArrow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _rightArrow() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: FaIcon(
        FontAwesomeIcons.chevronRight,
        color: Colors.grey,
        size: 16,
      ),
    );
  }

  Widget _habitData(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Hero(
              tag: habit,
              child: Text(
                habit.title,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: (habit.isTodayRecorded()
                        ? FontWeight.normal
                        : FontWeight.bold),
                    decoration: habit.isTodayRecorded()
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 18,
            child: LiquidLinearProgressIndicator(
              value: habit.recordedDays / 66,
              valueColor: AlwaysStoppedAnimation((habit.isTodayRecorded()
                  ? Theme.of(context).primaryColor
                  : Colors.grey)),
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              borderWidth: 1.0,
              borderRadius: 12.0,
              direction: Axis.horizontal,
              center: Text(
                "${habit.recordedDays} days",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
