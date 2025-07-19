import 'dart:convert';

import 'package:flutter/foundation.dart' hide debugPrint;
import 'package:flutter/services.dart';
import 'package:weather_app/models/current_weather_model.dart';

import 'utils/debug_print.dart';

class RustBridge {
  static const MethodChannel _channel = MethodChannel('com.example.weather_app/channel');

  static Future<String> getWeatherRaw(String city) async {
    try {
      final String result = await _channel.invokeMethod(
        'getWeatherFromRust',
        {
          'city': city,
        },
      );
      return result;
    } on PlatformException catch (e) {
      debugPrint('RustBridge error: ${e.message}');
      rethrow;
    }
  }

  static Future<WeatherResponse> getWeather(String city) async {
    try {
      final String result = await getWeatherRaw(city);
      debugPrint('Raw weather data: $result');

      final WeatherResponse response = await compute(_parseWeather, result);
      return response;
    } catch (e) {
      debugPrint('Error fetching weather: $e');
      rethrow;
    }
  }

// This function runs in a separate isolate
  static WeatherResponse _parseWeather(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return WeatherResponse.fromJson(jsonMap);
  }


}