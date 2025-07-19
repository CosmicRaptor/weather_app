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
  Widget build(BuildContext context) {
    final onboardingAsync = ref.watch(onboardingCompletedProvider);

    return onboardingAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
      data: (completed) {
        Future.microtask(() async {
          if (!mounted) return;
          if (completed) {
            await ref.read(weatherProvider("Mumbai").notifier).fetchWeather("Mumbai");
            if (context.mounted) {
              context.pushReplacement('/home');
            }
          } else {
            if (context.mounted) {
              context.pushReplacement('/onboarding');
            }
          }
        });

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}

