// Authors: Christos Georgakopoulos, Britney Ferguson
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error! Fetch Failed!')));
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
          // DONE: Organize the button to look neater
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter City"),
            ),
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text("Get Weather"),
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (_currentWeather != null)
              Card(
                color: Colors.white,
                elevation: 4, // Makes it look cool
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // City Name
                      Text(
                        _currentWeather!.cityName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Weather Icon
                      Image.network(
                        'https://openweathermap.org/payload/api/media/file/${_currentWeather!.iconCode}.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 16),

                      // Temperature
                      Text(
                        '${_currentWeather!.temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Weather Condition
                      Text(
                        _currentWeather!.condition,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
