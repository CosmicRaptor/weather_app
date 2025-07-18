import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen/viewmodel/home_screen_viewmodel.dart';

Future<bool> checkIfOnboardingCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_completed') ?? false;
}

Future<void> setOnboardingCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_completed', true);
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (await checkIfOnboardingCompleted()) {
        await ref.read(weatherProvider("Mumbai").notifier).fetchWeather("Mumbai");
        if (mounted) {
          context.pushReplacement('/home');
        }
      }
      else {
        if (mounted) {
          context.pushReplacement('/onboarding');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

