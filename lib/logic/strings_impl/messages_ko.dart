// ignore_for_file: annotate_overrides

import 'package:just66/logic/strings/messages.dart';

class KoreanMessages extends Messages {
  String get navBarHabits => "내 습관";

  String get completedHabitsPageTitle => "습관 카드";
  String get comingSoon => "습관을 완성하고 카드를 받으세요!";
  String youHaveXHabits(String count) => "지금까지 $count개의 습관을 만들었어요!";
  String get noCompletedHabits => "아직 완성된 습관이 없어요.";

  String get today => "진행 중";
  String get successfulDayTip => "습관 형성을 완료한 날";
  String get unsuccessfulDayTip => "습관 형성을 완료하지 못한 날";
  String get breakdown => "대시보드";
  String get deleteHabitDialogTitle => "습관 삭제";
  String deleteHabitDialogHint(String habitTitle) =>
      "정말로 형성 중인 $habitTitle 습관을 지우시겠어요? 이 작업은 되돌릴 수 없습니다.";
  String habitDaysSummary(int recordedDays, int totalHabitDuration) =>
      "$recordedDays/$totalHabitDuration\ndays";

  String get newHabitPageTitle => "새 습관 만들기";
  String get newHabitPageHint => "빠르게 습관 형성을 시작해보세요!";
  String get habitNameLabel => "습관 이름";
  String get habitNameEmptyError => "습관 이름을 작성해주세요!";
  String get createNewHabitButton => "습관 형성 시작!";

  String habitListPageTitle(int days) => "$days일의 기적!";
  String habitListPageSubtitle(int days) => "원하는 습관을 만들어보세요";
  String get currentlyActiveHabits => "진행 중인 습관들";
  String get noHabitsMessage => "아직 진행 중인 습관이 없어요.\n아래 버튼을 눌러 습관 형성을 시작하세요!";
  String get todaysStatus => "오늘의 습관";
  String get todaysStatusMessage => "오늘의 달성 수치를 여기서 확인해\n보세요. 100%를 향해 화이팅!";
  String get congratulationsDialogTitle => "축하합니다!";

  String get congratulationsDialogHint => "이제 이 습관은 완성 습관 페이지에서 다시 볼 수 있어요.";
  String habitDaysCount(int days) => "$days days";

  String get progressPageTitle => "차트";
  String get progressPageSubtitle => "진행상황을 차트로 확인해보세요!";
  String get time => "Time";
  String get noProgressMessage => "아직 기록된 데이터가 없어요.";
  String get toggleWeek => "Week";
  String get toggleMonth => "Month";
  String get toggleYear => "Year";

  String get underConstructionMessage => "아직 만들어지지 않은 페이지입니다.";

  String get settingsPageTitle => "설정";
  String get data => "데이터";
  String get resetAllData => "데이터 초기화";
  String get resetButtonText => "Clear";
  String get language => "언어";
  String get changeLanguage => "언어 설정";
  String get changeLanugageCompleteText => "변경된 언어를 적용하려면 앱을 재시작 해주세요.";
  String get deleteDataDialogTitle => "데이터 초기화";
  String get deleteDataDialogHint => "정말 모든 데이터를 지우시겠어요?\n\n이 작업은 되돌릴 수 없습니다.";
  String get deleteDialogSuccess => "데이터 초기화가 완료되었습니다.";
  String get about => "기타";
  String get version => "Version";
  String get loading => "Loading...";
  String get notifications => "알림";
  String get enableNotifications => "PUSH 알림";
  String get notificationsGuide => "놓친 습관이 있으면 22시에 알람을 보내줄게요.";

  String get ok => "OK";
  String get yes => "Yes";
  String get no => "No";
}
