import 'package:intl/intl.dart';

extension DateTimeHelpers on DateTime {
  String toYMD() => format("yyyy-MM-dd");

  static DateTime fromYMD(String formattedString) {
    return DateFormat('yyyy-MM-dd').parse(formattedString);
  }

  String format(String pattern) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(this);
  }
}
