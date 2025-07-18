/*
{
    "location": {
        "name": "Mumbai",
        "region": "Maharashtra",
        "country": "India",
        "lat": 18.975,
        "lon": 72.826,
        "tz_id": "Asia/Kolkata",
        "localtime_epoch": 1752779148,
        "localtime": "2025-07-18 00:35"
    },
    "current": {
        "last_updated_epoch": 1752778800,
        "last_updated": "2025-07-18 00:30",
        "temp_c": 29.1,
        "temp_f": 84.4,
        "is_day": 0,
        "condition": {
            "text": "Mist",
            "icon": "//cdn.weatherapi.com/weather/64x64/night/143.png",
            "code": 1030
        },
        "wind_mph": 11.0,
        "wind_kph": 17.6,
        "wind_degree": 229,
        "wind_dir": "SW",
        "pressure_mb": 1006.0,
        "pressure_in": 29.71,
        "precip_mm": 0.36,
        "precip_in": 0.01,
        "humidity": 79,
        "cloud": 75,
        "feelslike_c": 35.9,
        "feelslike_f": 96.5,
        "windchill_c": 27.2,
        "windchill_f": 81.0,
        "heatindex_c": 31.3,
        "heatindex_f": 88.4,
        "dewpoint_c": 24.4,
        "dewpoint_f": 75.9,
        "vis_km": 3.0,
        "vis_miles": 1.0,
        "uv": 0.0,
        "gust_mph": 15.5,
        "gust_kph": 25.0
    }
}
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/forecast_model.dart';

part 'current_weather_model.g.dart';

@JsonSerializable()
class WeatherResponse {
    final Location location;
    final Current current;
    final ForecastModel forecast;

    WeatherResponse({
        required this.location,
        required this.current,
        required this.forecast
    });

    factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
        _$WeatherResponseFromJson(json);

    Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class Location {
    final String name;
    final String region;
    final String country;
    final double lat;
    final double lon;
    final String tz_id;
    final int localtime_epoch;
    final String localtime;

    Location({
        required this.name,
        required this.region,
        required this.country,
        required this.lat,
        required this.lon,
        required this.tz_id,
        required this.localtime_epoch,
        required this.localtime
    });

    factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

    Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Current {
    final int last_updated_epoch;
    final String last_updated;
    final double temp_c;
    final double temp_f;
    final int is_day;
    final Condition condition;
    final double wind_mph;
    final double wind_kph;
    final int wind_degree;
    final String wind_dir;
    final double pressure_mb;
    final double pressure_in;
    final double precip_mm;
    final double precip_in;
    final int humidity;
    final int cloud;
    final double feelslike_c;
    final double feelslike_f;
    final double windchill_c;
    final double windchill_f;
    final double heatindex_c;
    final double heatindex_f;
    final double dewpoint_c;
    final double dewpoint_f;
    final double vis_km;
    final double vis_miles;
    final double uv;
    final double gust_mph;
    final double gust_kph;
    final AirQuality? air_quality;

    Current({
        required this.last_updated_epoch,
        required this.last_updated,
        required this.temp_c,
        required this.temp_f,
        required this.is_day,
        required this.condition,
        required this.wind_mph,
        required this.wind_kph,
        required this.wind_degree,
        required this.wind_dir,
        required this.pressure_mb,
        required this.pressure_in,
        required this.precip_mm,
        required this.precip_in,
        required this.humidity,
        required this.cloud,
        required this.feelslike_c,
        required this.feelslike_f,
        required this.windchill_c,
        required this.windchill_f,
        required this.heatindex_c,
        required this.heatindex_f,
        required this.dewpoint_c,
        required this.dewpoint_f,
        required this.vis_km,
        required this.vis_miles,
        required this.uv,
        required this.gust_mph,
        required this.gust_kph,
        required this.air_quality
    });

    factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
    Map<String, dynamic> toJson() => _$CurrentToJson(this);

}

@JsonSerializable()
class Condition {
    final String text;
    final String icon;
    final int code;

    Condition({
        required this.text,
        required this.icon,
        required this.code
    });

    factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);

    Map<String, dynamic> toJson() => _$ConditionToJson(this);
}