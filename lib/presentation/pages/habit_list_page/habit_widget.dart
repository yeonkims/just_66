import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../data/models/habit.dart';
import '../../extra_widgets/habit_checkbox.dart';
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
        left: 8.0,
        right: 8.0,
        top: 8.0,
        bottom: 2.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: cardRadius),
          child: InkWell(
            borderRadius: cardRadius,
            onTap: () {
              _goToNewPage(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              child: Row(
                children: [
                  HabitCheckbox(checked: habit.completed),
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

  _goToNewPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HabitDetailPage(habit: habit)),
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
            child: Text(
              habit.title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight:
                      (habit.completed ? FontWeight.normal : FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 18,
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
      ),
    );
  }
}
