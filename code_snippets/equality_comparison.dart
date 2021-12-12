import 'package:equatable/equatable.dart';

class Person extends Equatable {
  String name;
  int age;

  Person({
    required this.name,
    required this.age,
  });

  @override
  List<Object?> get props => [name, age];
}

void main(List<String> args) {
  Person person1 = Person(name: "tom", age: 23);
  Person person2 = Person(name: "tom", age: 24);

  print(person1 == person2);
}
