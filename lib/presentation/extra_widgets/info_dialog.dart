import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  String title;
  String? buttonText, hint;
  Function? onClick;

  InfoDialog({
    Key? key,
    required this.title,
    this.hint,
    this.buttonText,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(title),
      content: hint != null ? Text(hint!) : null,
      actions: [
        ElevatedButton(
          onPressed: () {
            onClick?.call();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(90, 35),
          ),
          child: Text(buttonText ?? 'OK'),
        )
        //_yesNoButtons(context),
      ],
    );
  }
}
