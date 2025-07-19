import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/screens/home_screen/widgets/sun_tracker.dart';

import '../../../core/utils/no_scroll_behaviour.dart';
import '../viewmodel/home_screen_viewmodel.dart';
import 'background_gif.dart';
import 'daily_forecast_container.dart';
import 'hourly_forecast_scroller.dart';
import 'info_tile.dart';

class HomeScreenBody extends ConsumerStatefulWidget {
  final String city;
  const HomeScreenBody({super.key, required this.city});

  @override
  ConsumerState<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends ConsumerState<HomeScreenBody> {

  @override
  Widget build (BuildContext context) {
    final city = widget.city;
    final vm = ref.watch(weatherProvider(city));
    final viewModel = ref.read(weatherProvider(city).notifier);

    if (vm.isLoading) {
      debugPrint("Loading weather data for $city...");
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (vm.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            vm.error!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    final response = vm.data;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    debugPrint("Weather data loaded for $city: ${response?.current.condition.text}");
    return Stack(
        children: [
          if (response != null)
          BackgroundGif(gifName: viewModel.getGifName(
              response.current.condition.code)),
          if (response != null)
            Positioned.fill(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ScrollConfiguration(
                    behavior: const NoGlowScrollBehavior(),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: height * 0.45,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // City name
                              Text(
                                response.location.name,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withValues(
                                          alpha: 0.4),
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              // Big Temperature Text
                              Text(
                                "${response.current.temp_c.round()}°",
                                style: TextStyle(
                                  fontSize: 150,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withValues(
                                          alpha: 0.4),
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              // Weather condition
                              Text(
                                response.current.condition.text,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withValues(
                                          alpha: 0.4),
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              // Min/Max Temperature
                              Text(
                                "H:${response
                                    .forecast.forecastday[0].day.maxtemp_c
                                    .round()}°  L:${response.forecast
                                    .forecastday[0].day.mintemp_c.round()}°",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withValues(
                                          alpha: 0.4),
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 40),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                        HourlyForecastScroller(forecast: response.forecast
                            .forecastday[0].hour + response.forecast
                            .forecastday[1].hour,
                        localTime: DateTime.parse(
                                response.location.localtime),
                        sunrise: vm.sunrise!,
                          sunset: vm.sunset!,
                        ),
                        const SizedBox(height: 12),

                        DailyForecastContainer(
                            dailyForecast: response.forecast.forecastday),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: InfoTile(
                                  Icons.water_drop_outlined,
                                  "Humidity",
                                  "${response.current.humidity}%",
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: InfoTile(
                                  Icons.wb_sunny_outlined,
                                  "UV Index",
                                  response.current.uv.toString(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: InfoTile(
                                  Icons.speed_outlined,
                                  "Pressure",
                                  "${response.current.pressure_mb} mb",
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
                                child: InfoTile(
                                  Icons.air_outlined,
                                  "Wind",
                                  "${response.current.wind_kph} km/h",
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: InfoTile(
                                  Icons.remove_red_eye_outlined,
                                  "Visibility",
                                  "${response.current.vis_km} km",
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: InfoTile(
                                  Icons.thermostat_outlined,
                                  "Feels Like",
                                  "${response.current.feelslike_c}°C",
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        AnimatedSunTracker(sunrise: vm.sunrise!,
                            sunset: vm.sunset!,
                            currentTime: DateTime.parse(
                                response.location.localtime)),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
  }
}
