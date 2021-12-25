// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:just66/data/models/habit.dart';
import 'package:just66/logic/repositories/habit_respository.dart';
import 'package:just66/presentation/extra_widgets/custom_title.dart';
import 'package:provider/provider.dart';

class SuccessHabitPage extends StatefulWidget {
  SuccessHabitPage({Key? key}) : super(key: key);

  @override
  State<SuccessHabitPage> createState() => _SuccessHabitPageState();
}

class _SuccessHabitPageState extends State<SuccessHabitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Successed habits",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text("Check your successed habits here!",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.grey[600],
                    )),
            CustomTitle(title: "Habits you made"),
            Expanded(child: CustomCard())
          ]),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: StreamBuilder<List<Habit>>(
              stream: Provider.of<HabitRepository>(context).getAllHabits(),
              builder: (context, habitsSnapshot) {
                if (!habitsSnapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (habitsSnapshot.data!.isEmpty) {
                  return Center(
                      child: Text("You have no completed habits yet."));
                } else {
                  final habits = habitsSnapshot.data!;
                  return Swiper(
                    loop: false,
                    itemCount: habits.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Center(
                          child: Text(
                            habits[index].title,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                  );
                }
              }),
        ),
      ),
    );
  }
}
