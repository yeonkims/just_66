// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final bool hasBottomBorder;

  const CustomTitle({
    required this.title,
    this.hasBottomBorder = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: !hasBottomBorder
          ? null
          : BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: Colors.black54,
                  width: 0.5,
                ),
              ),
            ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
