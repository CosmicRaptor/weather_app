import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/platform_bridge.dart';
import 'package:weather_app/models/current_weather_model.dart';

final weatherProvider = StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
  return WeatherViewModel();
});

class WeatherState {
  final WeatherResponse? data;
  final bool isLoading;
  final String? error;
  final DateTime? sunrise;
  final DateTime? sunset;

  const WeatherState({
    this.data,
    this.isLoading = false,
    this.error,
    this.sunrise,
    this.sunset,
  });

  WeatherState copyWith({
    WeatherResponse? data,
    bool? isLoading,
    String? error,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return WeatherState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}

class WeatherViewModel extends StateNotifier<WeatherState> {
  WeatherViewModel() : super(const WeatherState());

  Future<void> fetchWeather(String city) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await RustBridge.getWeather(city);
      final forecastDay = result.forecast.forecastday[0];
      final date = DateTime.parse(forecastDay.date);
      final format = DateFormat("hh:mm a");

      final sunriseTime = format.parse(forecastDay.astro.sunrise);
      final sunsetTime = format.parse(forecastDay.astro.sunset);

      final sunrise = DateTime(date.year, date.month, date.day, sunriseTime.hour, sunriseTime.minute);
      final sunset = DateTime(date.year, date.month, date.day, sunsetTime.hour, sunsetTime.minute);

      state = state.copyWith(
        data: result,
        sunrise: sunrise,
        sunset: sunset,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: "Failed to load weather", isLoading: false);
    }
  }
}
