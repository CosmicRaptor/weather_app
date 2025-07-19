import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/city_model.dart';

void main() {
  test('CityModel serializes and deserializes correctly', () {
    final json = {
      "name": "Mumbai",
      "country": "India",
    };

    final city = CityModel.fromJson(json);
    expect(city.name, 'Mumbai');
    expect(city.country, 'India');

    final toJson = city.toJson();
    expect(toJson, json);
  });
}
