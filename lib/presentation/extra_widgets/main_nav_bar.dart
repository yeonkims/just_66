// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just66/presentation/pages/habit_list/habit_list_page.dart';
import 'package:just66/presentation/pages/new_habit/new_habit_page.dart';
import 'package:just66/presentation/pages/completed_habits/completed_habits_page.dart';
import 'package:just66/presentation/pages/progress/progress_page.dart';
import 'package:just66/presentation/pages/settings/settings_page.dart';
import 'package:just66/presentation/utils/message_helpers.dart';
import 'package:just66/presentation/utils/navigation_helpers.dart';
import '../pages/under_construction/under_construction_page.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({Key? key}) : super(key: key);

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: IndexedStack(
        index: index,
        children: [
          HabitListPage(),
          ProgressPage(),
          SuccessHabitPage(),
          SettingsPage(),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavBar(context),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        context.openPage(NewHabitPage());
      },
      child: FaIcon(
        FontAwesomeIcons.plus,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  BottomNavigationBar _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.list),
          label: context.messages.navBarHabits,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.chartBar),
          label: context.messages.progressPageTitle,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.trophy),
          label: context.messages.completedHabitsPageTitle,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.cog),
          label: context.messages.settingsPageTitle,
        ),
      ],
      currentIndex: index,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (newIndex) {
        setState(() {
          index = newIndex;
        });
      },
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
