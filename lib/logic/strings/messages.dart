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

  String get settingsTitle;
  String get data;
  String get resetAllData;
  String get resetButtonText;
  String get changeLanguage;
  String get changeLanugageCompleteText;
}

class MessagesNotFoundException implements Exception {}
