import 'package:flutter/material.dart';
import 'package:weather_app/core/weather_icon_map.dart';

import '../../../models/forecast_model.dart';
import 'frosted_glass_container.dart';

class HourlyForecastScroller extends StatelessWidget {
  final List<HourlyForecast> forecast;
  late final List<HourlyForecast> upcomingForecast;

  HourlyForecastScroller({super.key, required this.forecast}) {
    upcomingForecast = forecast.where((hour) {
      final time = DateTime.parse(hour.time);
      return time.isAfter(DateTime.now());
    }).toList();
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
                    'assets/icons/day/$assetCode.png', // ex: 'sunny.png'
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
