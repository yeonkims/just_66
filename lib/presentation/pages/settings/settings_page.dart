// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, iterable_contains_unrelated_type

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/animated_checkbox.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:just66/presentation/extra_widgets/page_header.dart';
import 'package:just66/presentation/pages/settings/settings_option.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? versionNumber;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        versionNumber = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(title: "Settings", content: "your settings"),
              CustomTitle(title: "Data"),
              SettingsOption(
                title: "초기화",
                child: ElevatedButton(
                  child: Text("Clear"),
                  onPressed: () {},
                ),
              ),
              CustomTitle(title: "Notifications"),
              SettingsOption(
                title: "PUSH 알림",
                child: AnimatedCheckbox(
                  checked: false,
                  onChanged: (check) {},
                ),
              ),
              CustomTitle(title: "About"),
              SettingsOption(
                title: "Version",
                child: Text(versionNumber ?? "Loading..."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
