/*
"forecast": {
        "forecastday": [
            {
                "date": "2025-07-18",
                "date_epoch": 1752796800,
                "day": {
                    "maxtemp_c": 28.6,
                    "maxtemp_f": 83.5,
                    "mintemp_c": 27.1,
                    "mintemp_f": 80.8,
                    "avgtemp_c": 27.7,
                    "avgtemp_f": 81.9,
                    "maxwind_mph": 14.1,
                    "maxwind_kph": 22.7,
                    "totalprecip_mm": 4.88,
                    "totalprecip_in": 0.19,
                    "totalsnow_cm": 0.0,
                    "avgvis_km": 9.4,
                    "avgvis_miles": 5.0,
                    "avghumidity": 81,
                    "daily_will_it_rain": 1,
                    "daily_chance_of_rain": 98,
                    "daily_will_it_snow": 0,
                    "daily_chance_of_snow": 0,
                    "condition": {
                        "text": "Patchy rain nearby",
                        "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png",
                        "code": 1063
                    },
                    "uv": 1.9,
                    "air_quality": {
                        "co": 233.7166666666667,
                        "no2": 11.331249999999999,
                        "o3": 46.416666666666664,
                        "so2": 11.477708333333332,
                        "pm2_5": 27.194999999999993,
                        "pm10": 63.36250000000001,
                        "us-epa-index": 2,
                        "gb-defra-index": 3
                    }
                },
                "astro": {
                    "sunrise": "06:11 AM",
                    "sunset": "07:19 PM",
                    "moonrise": "No moonrise",
                    "moonset": "12:59 PM",
                    "moon_phase": "Last Quarter",
                    "moon_illumination": 50,
                    "is_moon_up": 1,
                    "is_sun_up": 0
                },
                "hour": [
                    {
                        "time_epoch": 1752777000,
                        "time": "2025-07-18 00:00",
                        "temp_c": 27.4,
                        "temp_f": 81.4,
                        "is_day": 0,
                        "condition": {
                            "text": "Patchy rain nearby",
                            "icon": "//cdn.weatherapi.com/weather/64x64/night/176.png",
                            "code": 1063
                        },
                        "wind_mph": 9.8,
                        "wind_kph": 15.8,
                        "wind_degree": 224,
                        "wind_dir": "SW",
                        "pressure_mb": 1006.0,
                        "pressure_in": 29.7,
                        "precip_mm": 0.17,
                        "precip_in": 0.01,
                        "snow_cm": 0.0,
                        "humidity": 85,
                        "cloud": 82,
                        "feelslike_c": 31.8,
                        "feelslike_f": 89.2,
                        "windchill_c": 27.4,
                        "windchill_f": 81.4,
                        "heatindex_c": 31.8,
                        "heatindex_f": 89.2,
                        "dewpoint_c": 24.6,
                        "dewpoint_f": 76.3,
                        "will_it_rain": 1,
                        "chance_of_rain": 100,
                        "will_it_snow": 0,
                        "chance_of_snow": 0,
                        "vis_km": 9.0,
                        "vis_miles": 5.0,
                        "gust_mph": 14.0,
                        "gust_kph": 22.6,
                        "uv": 0,
                        "air_quality": {
                            "co": 270.1,
                            "no2": 16.095,
                            "o3": 43.0,
                            "so2": 14.43,
                            "pm2_5": 33.115,
                            "pm10": 70.67,
                            "us-epa-index": 2,
                            "gb-defra-index": 3
                        }
                    },
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/current_weather_model.dart';

part 'forecast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  final List<ForecastDay> forecastday;

  ForecastModel({required this.forecastday});

  factory ForecastModel.fromJson(Map<String, dynamic> json) => _$ForecastModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}

@JsonSerializable()
class ForecastDay {
  final String date;
  final int date_epoch;
  final Day day;
  final Astro astro;
  final List<HourlyForecast> hour;

  ForecastDay({
    required this.date,
    required this.date_epoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);
}

@JsonSerializable()
class Day {
  final double maxtemp_c;
  final double maxtemp_f;
  final double mintemp_c;
  final double mintemp_f;
  final double avgtemp_c;
  final double avgtemp_f;
  final double maxwind_mph;
  final double maxwind_kph;
  final double totalprecip_mm;
  final double totalprecip_in;
  final int avghumidity;
  final Condition condition;
  @JsonKey(name: 'air_quality')
  final AirQuality? airQuality;

  Day({
    required this.maxtemp_c,
    required this.maxtemp_f,
    required this.mintemp_c,
    required this.mintemp_f,
    required this.avgtemp_c,
    required this.avgtemp_f,
    required this.maxwind_mph,
    required this.maxwind_kph,
    required this.totalprecip_mm,
    required this.totalprecip_in,
    required this.avghumidity,
    required this.condition,
    required this.airQuality,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moon_phase;
  final int moon_illumination;
  final int is_moon_up;
  final int is_sun_up;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moon_phase,
    required this.moon_illumination,
    required this.is_moon_up,
    required this.is_sun_up,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);
  Map<String, dynamic> toJson() => _$AstroToJson(this);
}

@JsonSerializable()
class HourlyForecast {
  final String time;
  final double temp_c;
  final double temp_f;
  final int is_day;
  final double wind_kph;
  final Condition condition;
  final double wind_mph;
  final double pressure_mb;
  final double precip_mm;
  final int humidity;
  final double feelslike_c;
  final double feelslike_f;

  HourlyForecast({
    required this.time,
    required this.temp_c,
    required this.temp_f,
    required this.is_day,
    required this.wind_kph,
    required this.condition,
    required this.wind_mph,
    required this.pressure_mb,
    required this.precip_mm,
    required this.humidity,
    required this.feelslike_c,
    required this.feelslike_f,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) => _$HourlyForecastFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}

@JsonSerializable()
class AirQuality {
  final double? co;
  final double? no2;
  final double? o3;
  final double? so2;
  final double? pm2_5;
  final double? pm10;
  @JsonKey(name: 'us-epa-index')
  final int? usEpaIndex;
  @JsonKey(name: 'gb-defra-index')
  final int? gbDefraIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => _$AirQualityFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityToJson(this);
}