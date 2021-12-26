import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  String title;
  String content;
  PageHeader({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
