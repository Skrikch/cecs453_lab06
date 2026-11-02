import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cecs453_lab06/services/weather_service.dart';

void main() async {
  // Reading text from '.env' file
  await dotenv.load(fileName: ".env");

  runApp(const MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: const WeatherHomeScreen(),
    );
  }

}