import 'package:path/path.dart';

class Weather {
  int temperature;

  Weather({required this.temperature});

  @override
  String toString() => "Weather: $temperature C";
}

bool isOdd(int number) {
  return number % 2 != 0;
}

void main(List<String> args) {
  List<int> numbers = [1, 2, 3, 4, 5, 6];

  final results = numbers.map((number) {
    return Weather(temperature: number);
  }).toList();

  print(results);

  List<int> results1 = [];

  for (int number in numbers) {
    results1.add(-(number));
  }

  print(results1);

  int number = 2;
  bool result = isOdd(number);
  print(result);

  //1: [true, false, true, false, true, false] >> if odd -> true, if even -> false
  //2: [-1, -2, -3, -4, -5, -6]
}
