// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:just66/presentation/utils/navigation_helpers.dart';
import 'package:provider/provider.dart';

class NewHabitPage extends StatefulWidget {
  NewHabitPage({Key? key}) : super(key: key);

  @override
  State<NewHabitPage> createState() => _NewHabitPageState();
}

class _NewHabitPageState extends State<NewHabitPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTitle(title: "Add your new habit!"),
              _habitInfoField(context),
              _createHabitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _createHabitButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newHabit =
                  Habit(title: _controller.text, startDate: DateTime.now());
              Provider.of<HabitRepository>(context, listen: false)
                  .createHabit(newHabit);
              context.closePage();
            }
          },
          child: Text(
            "Start making your new habit!",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding _habitInfoField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8,
          ),
          child: TextFormField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Write your new habit!";
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              label: Text("Habit name"),
              contentPadding: EdgeInsets.zero,
            ),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
