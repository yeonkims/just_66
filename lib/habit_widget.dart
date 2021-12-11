import 'package:flutter/material.dart';
import 'package:just66/habit.dart';

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    habit.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Text("${habit.days} days",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.apply(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
