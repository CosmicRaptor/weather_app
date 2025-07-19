import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/get_location.dart';
import 'package:weather_app/screens/home_screen/widgets/home_screen_body.dart';

import '../../core/prefs_storage.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  Widget _buildPageView(String? city, List<String> savedCities) {
    final locationCity = city ?? "Mumbai";
    final cities = [locationCity, ...savedCities];

    return Stack(
      children: [
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
                  children: [
                    // Page indicators
                    ...List.generate(cities.length, (index) {
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

                    const SizedBox(width: 12),

                    // + Add button
                    GestureDetector(
                      onTap: () {
                        context.push('/add-city');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(locationProvider);
    final savedCitiesAsync = ref.watch(savedCitiesProvider);

    return switch ((locationAsync, savedCitiesAsync)) {
      (AsyncLoading(), _) || (_, AsyncLoading()) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      (AsyncError(:final error, :final stackTrace), _) ||
      (_, AsyncError(:final error, :final stackTrace)) =>
          Scaffold(
            body: Center(child: Text('Error: $error, $stackTrace')),
          ),
      (AsyncData locationData, AsyncData savedCitiesData) =>
          _buildPageView(locationData.value.city, savedCitiesData.value),
      _ => const Scaffold(
        body: Center(child: Text('Unexpected state')),
      ),
    };
  }

}
