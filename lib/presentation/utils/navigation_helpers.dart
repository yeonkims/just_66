import 'package:flutter/material.dart';

extension NavigationHelpers on BuildContext {
  openPage(Widget newPage) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => newPage),
    );
  }

  closePage() {
    Navigator.of(this).pop();
  }
}
