import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedAppBar extends StatelessWidget {
  final String title;

  const FrostedAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AppBar(
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          elevation: 0,
          centerTitle: false,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
          ),
        ),
      ),
    );
  }
}
