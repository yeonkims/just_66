import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  String title;
  int days;
  bool completed;

  Habit({
    required this.title,
    required this.days,
    required this.completed,
  });

  @override
  List<Object?> get props => [title, days, completed];
}
