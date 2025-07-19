import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/screens/home_screen/widgets/frosted_glass_container.dart';

class AnimatedSunTracker extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime currentTime;

  const AnimatedSunTracker({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.currentTime,
  });

  double _calculateProgress() {
    final totalDuration = sunset.difference(sunrise).inSeconds.toDouble();
    final elapsed = currentTime.difference(sunrise).inSeconds.toDouble();
    return (elapsed / totalDuration).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final targetProgress = _calculateProgress();
    final timeFormatter = DateFormat.jm();

    return FrostedGlassContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Labels row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sunrise\n${timeFormatter.format(sunrise)}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  'Sunset\n${timeFormatter.format(sunset)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Progress bar
            LayoutBuilder(
              builder: (context, constraints) {
                final usableWidth = constraints.maxWidth;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: targetProgress),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOutCubic,
                  builder: (context, progress, child) {
                    return SizedBox(
                      height: 40,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // Track
                          Container(
                            height: 4,
                            width: usableWidth,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Progress Fill
                          Container(
                            height: 4,
                            width: usableWidth * progress,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Sun icon centered on tip
                          Positioned(
                            left: usableWidth * progress,
                            child: Transform.translate(
                              offset: const Offset(-16, 0), // half of 32 icon size
                              child: const Icon(
                                Icons.wb_sunny_rounded,
                                size: 32,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
