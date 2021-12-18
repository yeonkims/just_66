// ignore_for_file: prefer_const_constructors

class Weather {
  int temperature;
  String city;

  Weather({required this.temperature, required this.city});
}

Future<Weather> getLatestWeather() async {
  await Future.delayed(Duration(
    seconds: 4,
  ));
  return Weather(temperature: -3, city: "Seoul");
}

Future<int> getLatestTemperature() async {
  return (await getLatestWeather()).temperature;
}

int getVersion() {
  return 1;
}

void main(List<String> args) async {
  print("1 --- Application Start!");

  final futureTemperature = getLatestTemperature();

  print("2 --- Future Weather Loaded!");

  print("3 --- Application Finished!");
}
