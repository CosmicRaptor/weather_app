import 'package:flutter/material.dart';
import 'package:weather_app/core/weather_icon_map.dart';

import '../../../models/forecast_model.dart';
import 'frosted_glass_container.dart';

class HourlyForecastScroller extends StatelessWidget {
  final List<HourlyForecast> forecast;
  final DateTime localTime;
  final DateTime sunrise;
  final DateTime sunset;
  late final List<HourlyForecast> upcomingForecast;

  HourlyForecastScroller({super.key, required this.forecast, required this.localTime, required this.sunrise, required this.sunset}) {
    upcomingForecast = forecast.where((hour) {
      final time = DateTime.parse(hour.time);
      return time.isAfter(localTime);
    }).toList();
    debugPrint('Sunrise: $sunrise, Sunset: $sunset, Local Time: $localTime');
  }

  String isDayTime(DateTime forecastHour) {
    debugPrint('Checking if $forecastHour is day or night');
    final thisDaysSunrise = DateTime(
      forecastHour.year,
      forecastHour.month,
      forecastHour.day,
      sunrise.hour,
      sunrise.minute,
    );
    final thisDaysSunset = DateTime(
      forecastHour.year,
      forecastHour.month,
      forecastHour.day,
      sunset.hour,
      sunset.minute,
    );

    if (forecastHour.isAfter(thisDaysSunrise) && forecastHour.isBefore(thisDaysSunset)) {
      debugPrint('Daytime for $forecastHour');
      return 'day';
    } else {
      debugPrint('Nighttime for $forecastHour');
      return 'night';
    }
  }


  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 24, // Display 24 hours
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final hour = upcomingForecast[index];
              final time = DateTime.parse(hour.time);
              final assetCode = weatherIconMap[hour.condition.code.toString()];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Image.asset(
                    'assets/icons/${isDayTime(time)}/$assetCode.png', // ex: 'sunny.png'
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${hour.temp_c.round()}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
