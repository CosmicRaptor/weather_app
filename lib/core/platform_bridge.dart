import 'package:flutter/services.dart';

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

}