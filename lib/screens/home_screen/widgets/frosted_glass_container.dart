import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassContainer extends StatelessWidget {
  final Widget child;
  const FrostedGlassContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: Colors.white.withValues(alpha: 0.05),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
