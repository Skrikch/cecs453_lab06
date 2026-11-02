// Looks like `jsonDecode` won't work without this library
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cecs453_lab06/models/weather_model.dart';

class WeatherService {
  Future<WeatherData> fetchWeather(String city) async {
    // defining static variables for our API Key + Address
    final apiKey = dotenv.env['API_KEY'];
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    // If our response was OK
    if (response.statusCode == 200) {
      // Parse the JSON response into our model!
      final Map<String, dynamic> data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}