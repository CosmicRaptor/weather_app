import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/prefs_storage.dart';
import '../home_screen/viewmodel/home_screen_viewmodel.dart';

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
      if (ref.read(onboardingCompletedProvider).value == true) {
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

