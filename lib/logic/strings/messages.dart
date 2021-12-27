import 'package:just66/logic/strings_impl/messages_en.dart';
import 'package:just66/logic/strings_impl/messages_ko.dart';

abstract class Messages {
  static Messages loadMessages(String languageCode) {
    if (languageCode == "KO") {
      return KoreanMessages();
    } else if (languageCode == "EN") {
      return EnglishMessages();
    } else {
      throw MessagesNotFoundException();
    }
  }

  String get navBarHabits;

  String get completedHabitsPageTitle;
  String get comingSoon;
  String youHaveXHabits(String count);
  String get noCompletedHabits;

  String get today;
  String get successfulDayTip;
  String get unsuccessfulDayTip;
  String get breakdown;
  String get deleteHabitDialogTitle;
  String deleteHabitDialogHint(String habitTitle);
  String habitDaysSummary(int recordedDays, int totalHabitDuration);

  String get newHabitPageTitle;
  String get newHabitPageHint;
  String get habitNameLabel;
  String get habitNameEmptyError;
  String get createNewHabitButton;

  String habitListPageTitle(int days);
  String habitListPageSubtitle(int days);
  String get currentlyActiveHabits;
  String get noHabitsMessage;
  String get todaysStatus;
  String get todaysStatusMessage;
  String get congratulationsDialogTitle;
  String get congratulationsDialogHint;
  String habitDaysCount(int days);

  String get progressPageTitle;
  String get progressPageSubtitle;
  String get time;
  String get noProgressMessage;
  String get toggleWeek;
  String get toggleMonth;
  String get toggleYear;

  String get underConstructionMessage;

  String get settingsPageTitle;
  String get data;
  String get resetAllData;
  String get resetButtonText;
  String get language;
  String get changeLanguage;
  String get changeLanugageCompleteText;
  String get deleteDataDialogTitle;
  String get deleteDataDialogHint;
  String get deleteDialogSuccess;
  String get about;
  String get version;
  String get loading;
  String get notifications;
  String get enableNotifications;
  String get notificationsGuide;

  String get ok;
  String get yes;
  String get no;
}

class MessagesNotFoundException implements Exception {}
