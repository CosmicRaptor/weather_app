import 'package:flutter/material.dart';
import 'package:weather_app/core/weather_icon_map.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/screens/home_screen/widgets/frosted_glass_container.dart';

class DailyForecastContainer extends StatelessWidget {
  final List<ForecastDay> dailyForecast;
  const DailyForecastContainer({super.key, required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...dailyForecast.map((day) {
            final date = DateTime.parse(day.date);
            final iconUrl =
                'assets/icons/day/${weatherIconMap[day.day.condition.code.toString()]}.png';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(iconUrl, width: 40, height: 40),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${day.day.mintemp_c.round()}°",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${day.day.maxtemp_c.round()}°",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
