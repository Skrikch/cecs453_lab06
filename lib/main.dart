import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cecs453_lab06/screens/weather_screen.dart';

void main() async {
  // Required with an async main
  WidgetsFlutterBinding.ensureInitialized();
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
