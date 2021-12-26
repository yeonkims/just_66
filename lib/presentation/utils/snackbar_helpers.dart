// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

extension SnackbarHelpers on BuildContext {
  showSimpleSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
