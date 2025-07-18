import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/get_location.dart';
import 'package:weather_app/screens/splash_screen/splash_screen.dart';

class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  Future<void> tryLocation(WidgetRef ref, BuildContext context) async {
    final notif = ref.read(locationProvider.notifier);
    await notif.updateLocation(); // Handles both position and city
    final provider = ref.watch(locationProvider);
    debugPrint('Location updated: ${provider.value?.position}, City: ${provider.value?.city}');
    if (context.mounted) {
      setOnboardingCompleted();
      context.pushReplacement('/home');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    return Scaffold(
      // backgroundColor: const Color(0xFF101820),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Lottie animation
              Lottie.asset(
                'assets/animations/location.json',
                width: MediaQuery.of(context).size.width * 0.85,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              // Title
              const Text(
                'Enable Location Access',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtext
              Text(
                'We use your location to show local weather updates and forecasts.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Enable button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: locationState is AsyncLoading
                      ? null
                      : () => tryLocation(ref, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent.shade100,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: locationState is AsyncLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                    ),
                  )
                      : const Text(
                    'Enable Location',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Skip
              TextButton(
                onPressed: () {
                  // TODO: Handle skip logic (maybe continue to next onboarding page)
                },
                child: Text(
                  'Skip for now',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
