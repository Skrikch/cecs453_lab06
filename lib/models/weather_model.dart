class WeatherData {
  // Properties for our data model.
  final String cityName;
  final double temperature;
  final String condition;
  final String iconCode;

  // default constructor
  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.iconCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json){
    return WeatherData(
      // Creating mappings for each object we're looking for in the returned JSON data.
      cityName: json['name'] ?? 'unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'] ?? 'N/A',
      iconCode: json['weather'][0]['icon'] ?? '',
    );
  }
}