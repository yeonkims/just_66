// ignore_for_file: annotate_overrides

import 'package:just66/logic/strings/messages.dart';

class EnglishMessages extends Messages {
  String get navBarHabits => "My habits";

  String get completedHabitsPageTitle => "Completed habits";
  String get comingSoon => "Coming soon...";
  String youHaveXHabits(String count) => "You have completed $count habits!";
  String get noCompletedHabits => "You have no completed habits yet.";

  String get today => "Today";
  String get successfulDayTip => "Every day you complete this habit";
  String get unsuccessfulDayTip => "Every day you failed this habit";
  String get breakdown => "Breakdown";
  String get deleteHabitDialogTitle => "Delete habit?";
  String deleteHabitDialogHint(String habitTitle) =>
      "Are you sure you want to delete $habitTitle and all it's data?\n\nThis cannot be undone.";
  String habitDaysSummary(int recordedDays, int totalHabitDuration) =>
      "$recordedDays/$totalHabitDuration\ndays";

  String get newHabitPageTitle => "Create your new habit";
  String get newHabitPageHint => "get started in a few seconds!";
  String get habitNameLabel => "Habit name";
  String get habitNameEmptyError => "You must enter a habit name!";
  String get createNewHabitButton => "Start your new habit!";

  String habitListPageTitle(int days) => "Build new habits";
  String habitListPageSubtitle(int days) => "in just $days days!";
  String get currentlyActiveHabits => "Currently active habits";
  String get noHabitsMessage => "You have no habits yet. Please create one.";
  String get todaysStatus => "Today's status";
  String get todaysStatusMessage =>
      "View your daily status and try to reach 100% each day!";
  String get congratulationsDialogTitle => "Congratulations!";
  String get congratulationsDialogHint =>
      "You can now find this habit in the completed habits page!";
  String habitDaysCount(int days) => "$days days";

  String get progressPageTitle => "Progress";
  String get progressPageSubtitle =>
      "Check your progress over time, see how far you've come!";
  String get time => "Time";
  String get noProgressMessage => "You have no progress yet.";
  String get toggleWeek => "Week";
  String get toggleMonth => "Month";
  String get toggleYear => "Year";

  String get underConstructionMessage =>
      "This page is still under construction. Come back soon.";

  String get settingsPageTitle => "Settings";
  String get data => "Data";
  String get resetAllData => "Reset all data";
  String get resetButtonText => "Clear";
  String get language => "Language";
  String get changeLanguage => "Change Language";
  String get changeLanugageCompleteText =>
      "Restart the app to view it in English!";
  String get deleteDataDialogTitle => "Reset all data?";
  String get deleteDataDialogHint =>
      "This will delete ALL the habits you've created so far.\n\nAre you sure?";
  String get deleteDialogSuccess => "Successfully deleted!";
  String get about => "About";
  String get version => "Version";
  String get loading => "Loading...";
  String get notifications => "Notifications";
  String get enableNotifications => "Enable notifications";
  String get notificationsGuide =>
      "This will send you a notification with any missed habits by 10pm.";

  String get ok => "OK";
  String get yes => "Yes";
  String get no => "No";
}
