import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HabitCheckbox extends StatefulWidget {
  const HabitCheckbox({required this.checked, Key? key}) : super(key: key);
  final bool checked;
  //todo: add onTap;

  @override
  State<HabitCheckbox> createState() => _HabitCheckboxState();
}

class _HabitCheckboxState extends State<HabitCheckbox>
    with SingleTickerProviderStateMixin {
  late bool checked;
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();

    checked = widget.checked;

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
              (checked
                  ? FontAwesomeIcons.solidCheckCircle
                  : FontAwesomeIcons.checkCircle),
              size: sizeAnimation.value * 12 + 16,
              color: (checked ? Theme.of(context).primaryColor : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  _onTap() {
    setState(() {
      checked = !checked;
    });

    if (checked) {
      controller.forward(from: 0.0);
    }
  }
}
