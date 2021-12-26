// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, iterable_contains_unrelated_type

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/data/preferences/preferences.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/logic/strings/messages.dart';
import 'package:just66/presentation/extra_widgets/animated_checkbox.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:just66/presentation/extra_widgets/page_header.dart';
import 'package:just66/presentation/extra_widgets/pop_in_transition.dart';
import 'package:just66/presentation/extra_widgets/yes_no_dialog.dart';
import 'package:just66/presentation/pages/settings/settings_option.dart';
import 'package:just66/presentation/utils/constants.dart';
import 'package:just66/presentation/utils/message_helpers.dart';
import 'package:just66/presentation/utils/snackbar_helpers.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class Language {
  String code;
  String name;

  Language({
    required this.code,
    required this.name,
  });
}

class _SettingsPageState extends State<SettingsPage> {
  String? versionNumber;
  bool buttonChecked = false;
  String? currentLanguage;

  Preferences preferences = Preferences();

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        versionNumber = packageInfo.version;
      });
    });
    _loadPreferences();
  }

  _loadPreferences() async {
    buttonChecked =
        await preferences.getPreference(Preferences.IS_NOTIFICATIONS_ENABLED);
    currentLanguage =
        await preferences.getPreference(Preferences.SELECTED_LANGUAGE);
    setState(() {});
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
              PageHeader(
                title: context.messages.settingsTitle,
              ),
              _dataOptions(context),
              kDebugMode ? _languageOptions(context) : Container(),
              kDebugMode ? _notificationOptions(context) : Container(),
              _aboutOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Column _languageOptions(BuildContext context) {
    return Column(
      children: [
        CustomTitle(
          title: "Language",
          hasBottomBorder: true,
        ),
        SettingsOption(
          title: context.messages.changeLanguage,
          child: DropdownButton<String>(
            value: currentLanguage,
            onChanged: (value) {
              preferences.updatePreference(
                  Preferences.SELECTED_LANGUAGE, value);
              context.showSimpleSnackbar(
                  context.messages.changeLanugageCompleteText);
              setState(() {
                currentLanguage = value;
              });
            },
            items: Constants.ALL_LANGUAGES.map((language) {
              return DropdownMenuItem<String>(
                value: language.code,
                child: Text(language.name),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column _dataOptions(BuildContext context) {
    return Column(
      children: [
        CustomTitle(
          title: context.messages.data,
          hasBottomBorder: true,
        ),
        SettingsOption(
          title: context.messages.resetAllData,
          child: ElevatedButton(
            child: Text(context.messages.resetButtonText),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return PopInTransition(
                    child: YesNoDialog(
                      title: "Warning!",
                      hint:
                          "Are you sure you want to delete ALL your data?!\n\nThis cannot be undone.",
                      onYes: () {
                        Provider.of<HabitRepository>(context, listen: false)
                            .deleteAll();
                        context.showSimpleSnackbar("Successfully deleted!");
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column _aboutOptions() {
    return Column(
      children: [
        CustomTitle(
          title: "About",
          hasBottomBorder: true,
        ),
        SettingsOption(
          title: "Version",
          child: Text(versionNumber ?? "Loading..."),
        ),
      ],
    );
  }

  Widget _notificationOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          title: "Notifications",
          hasBottomBorder: true,
        ),
        SettingsOption(
          title: "PUSH 알림",
          child: AnimatedCheckbox(
            checked: buttonChecked,
            onChanged: (checked) {
              preferences.updatePreference(
                  Preferences.IS_NOTIFICATIONS_ENABLED, !buttonChecked);
              setState(() {
                buttonChecked = !buttonChecked;
              });
            },
          ),
        ),
        Text(
          "놓친 습관이 있으면 22시에 알람을 보내줄게요.",
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontStyle: FontStyle.italic,
              ),
        ),
      ],
    );
  }
}
