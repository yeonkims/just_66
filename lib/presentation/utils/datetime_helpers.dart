import 'package:intl/intl.dart';

extension DateTimeHelpers on DateTime {
  String toYMD() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  static DateTime fromYMD(String formattedString) {
    return DateFormat('yyyy-MM-dd').parse(formattedString);
  }
}
