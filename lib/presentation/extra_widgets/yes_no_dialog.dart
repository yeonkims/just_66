import 'package:flutter/material.dart';
import 'package:just66/presentation/utils/message_helpers.dart';

class YesNoDialog extends StatelessWidget {
  String title;
  String? hint, yesText, noText;
  VoidCallback onYes;

  YesNoDialog({
    Key? key,
    required this.title,
    this.hint,
    this.yesText,
    this.noText,
    required this.onYes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: hint != null ? Text(hint!) : null,
      actions: [
        _yesNoButtons(context),
      ],
    );
  }

  SizedBox _yesNoButtons(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(noText ?? context.messages.no),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  onYes();
                  Navigator.pop(context);
                },
                child: Text(yesText ?? context.messages.yes),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
