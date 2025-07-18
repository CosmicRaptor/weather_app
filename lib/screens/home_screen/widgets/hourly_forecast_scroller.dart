import 'package:flutter/material.dart';
import 'package:weather_app/core/weather_icon_map.dart';

import '../../../models/forecast_model.dart';
import 'frosted_glass_container.dart';

class HourlyForecastScroller extends StatelessWidget {
  final List<HourlyForecast> forecast;

  const HourlyForecastScroller({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Display only the first 10 hours
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final hour = forecast[index];
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
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${hour.temp_c}°C',
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
