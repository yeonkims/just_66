import 'package:flutter/material.dart';

class PopInTransition extends StatefulWidget {
  final Widget child;

  const PopInTransition({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopInTransitionState();
}

class PopInTransitionState extends State<PopInTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: scaleAnimation, child: widget.child);
  }
}
