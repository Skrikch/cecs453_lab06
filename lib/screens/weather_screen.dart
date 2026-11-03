import 'package:flutter/material.dart';
import 'package:cecs453_lab06/models/weather_model.dart';
import 'package:cecs453_lab06/services/weather_service.dart';


// Decalring a stateful widget for our screen
class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final TextEditingController _controller = TextEditingController();
  WeatherData? _currentWeather;
  bool _isLoading = false;

  // Private method that calls upon our WeatherService, and waits for the response
  void _getWeather() async {
    // modify _isLoading for our cool spinnybob
    setState(() => _isLoading = true);
    try {
      final service = WeatherService();
      final data = await service.fetchWeather(_controller.text);
      setState(() {
        _currentWeather = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // DONE: Handle error (e.g., show a SnackBar or something cool)
      const errorBar = SnackBar(content: Text('Error! Fetch Failed!'));
      ScaffoldMessenger.of(context).showSnackBar(errorBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // main body of our app
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // TODO: Organize the button to look neater
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter City"),
            ),
            ElevatedButton(onPressed: _getWeather, child: const Text("Get Weather")),
            if (_isLoading) const CircularProgressIndicator(),
            if (_currentWeather != null)
              Column(
                // TODO: Make this look nice
                children: [
                  Text("City: ${_currentWeather!.cityName}"),
                  Text("Temp: ${_currentWeather!.temperature}°C"),
                  Text("Condition: ${_currentWeather!.condition}"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}