import 'package:flutter_test/flutter_test.dart';
import 'package:ronkhlab_agro/models/meteo_model.dart';

void main() {
  test("MeteoModel - JSON Parsing", () {
    final json = {
      "weather": [
        {"description": "ciel dégagé"},
      ],
      "main": {"temp": 30.5, "humidity": 40},
    };

    final meteo = MeteoModel.fromJson(json);

    expect(meteo.description, "ciel dégagé");
    expect(meteo.temperature, 30.5);
    expect(meteo.humidity, 40);
  });
}
