import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  String title;
  Widget child;
  SettingsOption({
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
          child,
        ],
      ),
    );
  }
}
