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

part 'current_weather_model.g.dart';

@JsonSerializable()
class WeatherResponse {
    final Location location;
    final Current current;

    WeatherResponse({
        required this.location,
        required this.current
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
    final String tzId;
    final int localtimeEpoch;
    final String localtime;

    Location({
        required this.name,
        required this.region,
        required this.country,
        required this.lat,
        required this.lon,
        required this.tzId,
        required this.localtimeEpoch,
        required this.localtime
    });

    factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

    Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Current {
    final int lastUpdatedEpoch;
    final String lastUpdated;
    final double tempC;
    final double tempF;
    final int isDay;
    final Condition condition;
    final double windMph;
    final double windKph;
    final int windDegree;
    final String windDir;
    final double pressureMb;
    final double pressureIn;
    final double precipMm;
    final double precipIn;
    final int humidity;
    final int cloud;
    final double feelslikeC;
    final double feelslikeF;
    final double windchillC;
    final double windchillF;
    final double heatindexC;
    final double heatindexF;
    final double dewpointC;
    final double dewpointF;
    final double visKm;
    final double visMiles;
    final double uv;
    final double gustMph;
    final double gustKph;

    Current({
        required this.lastUpdatedEpoch,
        required this.lastUpdated,
        required this.tempC,
        required this.tempF,
        required this.isDay,
        required this.condition,
        required this.windMph,
        required this.windKph,
        required this.windDegree,
        required this.windDir,
        required this.pressureMb,
        required this.pressureIn,
        required this.precipMm,
        required this.precipIn,
        required this.humidity,
        required this.cloud,
        required this.feelslikeC,
        required this.feelslikeF,
        required this.windchillC,
        required this.windchillF,
        required this.heatindexC,
        required this.heatindexF,
        required this.dewpointC,
        required this.dewpointF,
        required this.visKm,
        required this.visMiles,
        required this.uv,
        required this.gustMph,
        required this.gustKph
    });

    factory Current.fromJson(Map<String, dynamic> json) =>
        _$CurrentFromJson(json);

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