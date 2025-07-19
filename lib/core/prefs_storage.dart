import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Check if onboarding is completed
final onboardingCompletedProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_completed') ?? false;
});

// Get saved cities
final savedCitiesProvider = FutureProvider<List<String>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('saved_cities') ?? [];
});

Future<void> setOnboardingCompleted(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_completed', true);
  ref.invalidate(onboardingCompletedProvider);
}

Future<void> saveCity(WidgetRef ref, String city) async {
  final prefs = await SharedPreferences.getInstance();
  final current = prefs.getStringList('saved_cities') ?? [];
  if (!current.contains(city)) {
    current.add(city);
    await prefs.setStringList('saved_cities', current);
    ref.invalidate(savedCitiesProvider);
  }
}

Future<void> removeCity(WidgetRef ref, String city) async {
  final prefs = await SharedPreferences.getInstance();
  final current = prefs.getStringList('saved_cities') ?? [];
  if (current.contains(city)) {
    current.remove(city);
    await prefs.setStringList('saved_cities', current);
    ref.invalidate(savedCitiesProvider);
  }
}

Future<void> reArrangeCities(WidgetRef ref, List<String> newList) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('saved_cities', newList);
  ref.invalidate(savedCitiesProvider);
}
