// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/info_dialog.dart';
import 'package:just66/presentation/extra_widgets/pop_in_transition.dart';
import 'package:just66/presentation/extra_widgets/yes_no_dialog.dart';
import 'package:just66/presentation/utils/constants.dart';
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
                        _createRecord(context);
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

  void _createRecord(BuildContext context) {
    final newRecord = Record(recordDate: DateTime.now(), habitId: habit.id!);
    Provider.of<HabitRepository>(context, listen: false)
        .createRecord(newRecord);

    final isFinalRecord = habit.recordedDays == Constants.NUMBER_OF_HABITS - 1;
    if (isFinalRecord) {
      _completeHabit(context);
    }
  }

  void _completeHabit(BuildContext context) {
    Provider.of<HabitRepository>(context, listen: false)
        .completeHabit(habit.id!);
    showDialog(
        context: context,
        builder: (ctx) {
          return PopInTransition(
            child: InfoDialog(
              title: "Congraturations!",
              hint: "앞으로는 success페이지에 있을것",
            ),
          );
        });
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
              value: habit.recordedDays / Constants.NUMBER_OF_HABITS,
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
