import 'package:flutter/material.dart';

import '../../core/platform_bridge.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController(text: "Mumbai");
  String _weather = "No data";

  Future<void> _getWeather() async {
    try {
      final result = await RustBridge.getWeatherRaw(_controller.text);
      setState(() => _weather = result);
    } catch (e) {
      setState(() => _weather = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rust Weather")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 32),
            Text(_weather, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
