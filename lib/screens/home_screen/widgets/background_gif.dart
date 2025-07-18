import 'package:flutter/material.dart';

class BackgroundGif extends StatelessWidget {
  final String gifName;
  const BackgroundGif({super.key, required this.gifName});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/gifs/$gifName',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      repeat: ImageRepeat.repeat,
    );
  }
}
