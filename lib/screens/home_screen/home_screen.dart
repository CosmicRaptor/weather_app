import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/get_location.dart';
import 'package:weather_app/screens/home_screen/widgets/home_screen_body.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> favoriteCities = ["London", "New York", "Tokyo", "Delhi", "Sydney"];

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
        final locationCity = location.city ?? "Mumbai";
        debugPrint("Location: ${location.position}, City: $locationCity");

        // Build full city list
        final cities = [locationCity, ...favoriteCities];

        return Stack(
          children: [
            // 1. Fullscreen weather body with PageView
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              body: PageView.builder(
                controller: _controller,
                itemCount: cities.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return HomeScreenBody(city: city);
                },
              ),
            ),

            // 2. Blurred bottom nav bar overlay
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(cities.length, (index) {
                        final isSelected = index == _currentPage;
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            height: 10,
                            width: isSelected ? 20 : 10,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

      },
    );
  }
}
