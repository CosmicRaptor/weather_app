import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/get_location.dart';
import 'package:weather_app/core/utils/no_scroll_behaviour.dart';
import 'package:weather_app/screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:weather_app/screens/home_screen/widgets/background_gif.dart';
import 'package:weather_app/screens/home_screen/widgets/daily_forecast_container.dart';
import 'package:weather_app/screens/home_screen/widgets/hourly_forecast_scroller.dart';
import 'package:weather_app/screens/home_screen/widgets/info_tile.dart';
import 'package:weather_app/screens/home_screen/widgets/sun_tracker.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  Widget _body (String city) {
    final vm = ref.watch(weatherProvider(city));

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
                                      color: Colors.black.withValues(
                                          alpha: 0.4),
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${response.current.condition.text} ${response
                                    .forecast.forecastday[0].day.mintemp_c
                                    .round()}° / ${response.forecast
                                    .forecastday[0].day.maxtemp_c.round()}°",
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
                              // const SizedBox(height: 8),
                            ],
                          ),
                        ),

                        // const SizedBox(height: 40),
                        HourlyForecastScroller(forecast: response.forecast
                            .forecastday[0].hour + response.forecast
                            .forecastday[1].hour),
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
                            currentTime: DateTime.now()),
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

  @override
  Widget build(BuildContext context) {
    final cityAsync = ref.watch(locationProvider);

    return cityAsync.when(
      loading: () {
        debugPrint("Loading location...");
        return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
      },
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (location) {
        final city = location.city ?? "Mumbai";
        debugPrint("Location: ${location.position}, City: $city");
        return _body(city);
      },
    );
  }

}
