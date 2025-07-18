import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/no_scroll_behaviour.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/screens/home_screen/widgets/background_gif.dart';
import 'package:weather_app/screens/home_screen/widgets/frosted_app_bar.dart';
import 'package:weather_app/screens/home_screen/widgets/frosted_glass_container.dart';
import 'package:weather_app/screens/home_screen/widgets/hourly_forecast_scroller.dart';

import '../../core/platform_bridge.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController(text: "Mumbai");
  WeatherResponse? response;

  Future<void> _getWeather() async {
    try {
      final result = await RustBridge.getWeather(_controller.text);
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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    iconUsed,
                    size: constraints.maxWidth * 0.25, // Scales with width
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.150, // Scales with width
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
                      fontSize: constraints.maxWidth * 0.20, // Bigger than label
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: FrostedAppBar(title: 'Mumbai'), // custom app bar
      ),
      body: Stack(
        children: [
          const BackgroundGif(gifName: 'clear.gif'),
          if (response != null)
          Positioned.fill(
            child: SafeArea(
              child: ScrollConfiguration(
                behavior: const NoGlowScrollBehavior(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
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
                                "Clear 27° / 32°",
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
                        HourlyForecastScroller(forecast: response!.forecast.forecastday[0].hour),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(child: _infoTile(Icons.water_drop_outlined, "Humidity", "${response!.current.humidity}%")),
                            const SizedBox(width: 12),
                            Expanded(child: _infoTile(Icons.wb_sunny_outlined, "UV Index", response!.current.uv.toString())),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _infoTile(Icons.air_outlined, "Wind", "${response!.current.wind_kph} km/h")),
                            const SizedBox(width: 12),
                            Expanded(child: _infoTile(Icons.speed_outlined, "Pressure", "${response!.current.pressure_mb} mb")),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _infoTile(Icons.thermostat_outlined, "Feels Like", "${response!.current.feelslike_c}°C")),
                            const SizedBox(width: 12),
                            Expanded(child: _infoTile(Icons.remove_red_eye_outlined, "Visibility", "${response!.current.vis_km} km")),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _infoTile(Icons.grain_outlined, "Dew Point", "${response!.current.dewpoint_c}°C")),
                            const SizedBox(width: 12),
                            Expanded(child: _infoTile(Icons.cloud_outlined, "Cloud Cover", "${response!.current.cloud}%")),
                          ],
                        ),
                      ],
                    ),
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
