import 'package:flutter/material.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/presentation/extra_widgets/habit_checkbox.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HabitWidget extends StatelessWidget {
  const HabitWidget({
    required this.habit,
    Key? key,
  }) : super(key: key);

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                HabitCheckbox(checked: habit.completed),
                Expanded(child: _habitData(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _habitData(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            habit.title,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight:
                    (habit.completed ? FontWeight.normal : FontWeight.bold)),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 20,
          child: LiquidLinearProgressIndicator(
            value: habit.days / 66,
            valueColor: AlwaysStoppedAnimation((habit.completed
                ? Theme.of(context).primaryColor
                : Colors.grey)),
            backgroundColor: Colors.white,
            borderColor: Colors.black,
            borderWidth: 1.0,
            borderRadius: 12.0,
            direction: Axis.horizontal,
            center: Text(
              "${habit.days} days",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
      ],
    );
  }
}
