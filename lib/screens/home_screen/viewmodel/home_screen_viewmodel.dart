import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/platform_bridge.dart';
import 'package:weather_app/models/current_weather_model.dart';

final weatherProvider =
    StateNotifierProvider.family<WeatherViewModel, WeatherState, String>((
      ref,
      city,
    ) {
      return WeatherViewModel(city);
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
  final String cityName;
  WeatherViewModel(this.cityName) : super(const WeatherState()) {
    fetchWeather(cityName);
  }

  String getGifName(int weatherCode) {
    final clearCodes = [1000, 1003, 1006, 1009, 1030, 1087, 1135, 1147];
    final rainyCodes = [
      1063,
      1069,
      1072,
      1150,
      1153,
      1168,
      1171,
      1180,
      1183,
      1186,
      1189,
      1192,
      1195,
      1198,
      1201,
      1204,
      1207,
      1237,
      1240,
      1243,
      1246,
      1249,
      1252,
      1261,
      1264,
      1273,
      1276,
    ];
    final snowyCodes = [
      1066,
      1114,
      1117,
      1210,
      1213,
      1216,
      1219,
      1222,
      1225,
      1255,
      1258,
      1279,
      1282,
    ];

    if (clearCodes.contains(weatherCode)) {
      return "clear.gif";
    } else if (rainyCodes.contains(weatherCode)) {
      return "rain.gif";
    } else if (snowyCodes.contains(weatherCode)) {
      return "snow.gif";
    } else {
      return "clear.gif"; // Default to clear if no match found
    }
  }

  Future<void> fetchWeather(String city) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await RustBridge.getWeather(city);
      final forecastDay = result.forecast.forecastday[0];
      final date = DateTime.parse(forecastDay.date);
      final format = DateFormat("hh:mm a");

      final sunriseTime = format.parse(forecastDay.astro.sunrise);
      final sunsetTime = format.parse(forecastDay.astro.sunset);

      final sunrise = DateTime(
        date.year,
        date.month,
        date.day,
        sunriseTime.hour,
        sunriseTime.minute,
      );
      final sunset = DateTime(
        date.year,
        date.month,
        date.day,
        sunsetTime.hour,
        sunsetTime.minute,
      );

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
