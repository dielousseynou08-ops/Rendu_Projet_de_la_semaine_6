class MeteoModel {
  final String description;
  final double temperature;
  final double humidity;

  MeteoModel({
    required this.description,
    required this.temperature,
    required this.humidity,
  });

  factory MeteoModel.fromJson(Map<String, dynamic> json) {
    return MeteoModel(
      description: json['weather'][0]['description'],
      temperature: (json['main']['temp']).toDouble(),
      humidity: (json['main']['humidity']).toDouble(),
    );
  }
}
