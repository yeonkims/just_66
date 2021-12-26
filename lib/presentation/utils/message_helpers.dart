import 'package:flutter/cupertino.dart';
import 'package:just66/logic/strings/messages.dart';
import 'package:provider/provider.dart';

extension SnackbarHelpers on BuildContext {
  Messages get messages {
    return Provider.of<Messages>(this, listen: false);
  }
}
