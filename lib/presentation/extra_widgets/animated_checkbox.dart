import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/data/models/record.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:provider/provider.dart';

class AnimatedCheckbox extends StatefulWidget {
  const AnimatedCheckbox({
    required this.checked,
    required this.onChanged,
    this.isLarge = false,
    Key? key,
  }) : super(key: key);
  final bool checked;
  final bool isLarge;
  final Function(bool) onChanged;
  //todo: add onTap;

  @override
  State<AnimatedCheckbox> createState() => _AnimatedCheckboxState();
}

class _AnimatedCheckboxState extends State<AnimatedCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    sizeAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    controller.value = 1.0;

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          _onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: FaIcon(
              (widget.checked
                  ? FontAwesomeIcons.solidCheckCircle
                  : FontAwesomeIcons.checkCircle),
              size: sizeAnimation.value * 12 + (widget.isLarge ? 22 : 16),
              color: (widget.checked
                  ? Theme.of(context).primaryColor
                  : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  _onTap() {
    if (!widget.checked) {
      controller.forward(from: 0.0);
    }
    widget.onChanged(!widget.checked);
  }
}
