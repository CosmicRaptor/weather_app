import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/forecast_model.dart';

void main() {
  test('ForecastModel deserializes from JSON correctly', () {
    final json = {
      "forecastday": [
        {
          "date": "2025-07-19",
          "date_epoch": 1752844800,
          "day": {
            "maxtemp_c": 30.5,
            "maxtemp_f": 86.9,
            "mintemp_c": 24.0,
            "mintemp_f": 75.2,
            "avgtemp_c": 27.0,
            "avgtemp_f": 80.6,
            "maxwind_mph": 10.5,
            "maxwind_kph": 16.9,
            "totalprecip_mm": 0.0,
            "totalprecip_in": 0.0,
            "avghumidity": 65,
            "condition": {
              "text": "Sunny",
              "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
              "code": 1000
            },
            "air_quality": null
          },
          "astro": {
            "sunrise": "06:00 AM",
            "sunset": "07:00 PM",
            "moonrise": "08:00 PM",
            "moonset": "06:00 AM",
            "moon_phase": "Waxing Gibbous",
            "moon_illumination": 73,
            "is_moon_up": 1,
            "is_sun_up": 1
          },
          "hour": [
            {
              "time": "2025-07-19 00:00",
              "temp_c": 25.0,
              "temp_f": 77.0,
              "is_day": 0,
              "wind_kph": 5.0,
              "wind_mph": 3.1,
              "pressure_mb": 1012.0,
              "precip_mm": 0.0,
              "humidity": 80,
              "feelslike_c": 26.0,
              "feelslike_f": 78.8,
              "condition": {
                "text": "Clear",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                "code": 1000
              }
            }
          ]
        }
      ]
    };

    final forecast = ForecastModel.fromJson(json);

    expect(forecast.forecastday.length, 1);

    final day = forecast.forecastday.first.day;
    expect(day.maxtemp_c, 30.5);
    expect(day.condition.text, "Sunny");
    expect(day.airQuality, isNull);

    final astro = forecast.forecastday.first.astro;
    expect(astro.sunrise, "06:00 AM");
    expect(astro.sunset, "07:00 PM");

    final hour = forecast.forecastday.first.hour.first;
    expect(hour.temp_c, 25.0);
    expect(hour.condition.code, 1000);
    expect(hour.is_day, 0);
  });
}
