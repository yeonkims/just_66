import 'package:flutter/material.dart';
import 'package:just66/presentation/pages/habit_list_page/habit_list_page.dart';
import 'package:just66/presentation/pages/under_construction_page.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HabitListPage(),
    );
  }
}
