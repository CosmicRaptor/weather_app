import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/utils/no_scroll_behaviour.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/screens/home_screen/widgets/background_gif.dart';
import 'package:weather_app/screens/home_screen/widgets/daily_forecast_container.dart';
import 'package:weather_app/screens/home_screen/widgets/frosted_glass_container.dart';
import 'package:weather_app/screens/home_screen/widgets/hourly_forecast_scroller.dart';
import 'package:weather_app/screens/home_screen/widgets/sun_tracker.dart';

import '../../core/platform_bridge.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController(text: "Mumbai");
  WeatherResponse? response;
  late final sunrise;
  late final sunset;

  Future<void> _getWeather() async {
    try {
      final result = await RustBridge.getWeather(_controller.text);
      final forecastDay = result.forecast.forecastday[0];
      final date = DateTime.parse(forecastDay.date); // e.g., "2025-07-18"
      final format = DateFormat("hh:mm a");

      final sunriseTimeOnly = format.parse(forecastDay.astro.sunrise); // just the time
      final sunsetTimeOnly = format.parse(forecastDay.astro.sunset);   // just the time

      sunrise = DateTime(date.year, date.month, date.day, sunriseTimeOnly.hour, sunriseTimeOnly.minute);
      sunset = DateTime(date.year, date.month, date.day, sunsetTimeOnly.hour, sunsetTimeOnly.minute);
      setState(() => response = result);
    } catch (e, stackTrace) {
      debugPrint('Error fetching weather: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  @override
  void initState() {
    _getWeather();
    super.initState();
  }

  Widget _infoTile(IconData iconUsed, String label, String value) {
    return FrostedGlassContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  iconUsed,
                  size: constraints.maxWidth * 0.3, // Scales with width
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.2, // Scales with width
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.2, // Bigger than label
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(80),
      //   child: FrostedAppBar(title: 'Mumbai'), // custom app bar
      // ),
      body: Stack(
        children: [
          const BackgroundGif(gifName: 'rain.gif'),
          if (response != null)
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ScrollConfiguration(
                  behavior: const NoGlowScrollBehavior(),
                  child: ListView(
                    children: [
                      // Big Temperature Text
                      SizedBox(
                        height: height * 0.35,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "29°",
                              style: TextStyle(
                                fontSize: 150,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withValues(alpha: 0.4),
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${response!.current.condition.text} ${response!.forecast.forecastday[0].day.mintemp_c.round()}° / ${response!.forecast.forecastday[0].day.maxtemp_c.round()}°",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withValues(alpha: 0.4),
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 8),
                          ],
                        ),
                      ),

                      // const SizedBox(height: 40),
                      HourlyForecastScroller(forecast: response!.forecast.forecastday[0].hour + response!.forecast.forecastday[1].hour),
                      const SizedBox(height: 12),

                      DailyForecastContainer(dailyForecast: response!.forecast.forecastday),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _infoTile(
                                Icons.water_drop_outlined,
                                "Humidity",
                                "${response!.current.humidity}%",
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _infoTile(
                                Icons.wb_sunny_outlined,
                                "UV Index",
                                response!.current.uv.toString(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _infoTile(
                                Icons.speed_outlined,
                                "Pressure",
                                "${response!.current.pressure_mb} mb",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _infoTile(
                                Icons.air_outlined,
                                "Wind",
                                "${response!.current.wind_kph} km/h",
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _infoTile(
                                Icons.remove_red_eye_outlined,
                                "Visibility",
                                "${response!.current.vis_km} km",
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: _infoTile(
                                Icons.thermostat_outlined,
                                "Feels Like",
                                "${response!.current.feelslike_c}°C",
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      AnimatedSunTracker(sunrise: sunrise, sunset: sunset, currentTime: DateTime.now()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
