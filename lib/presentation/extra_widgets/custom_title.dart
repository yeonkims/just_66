// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: 24.0, top: 20.0),
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );
  }
}
