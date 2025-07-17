import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ✅ Platform channel declaration
const MethodChannel platform = MethodChannel('com.example.weather_app/channel');

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WeatherHome());
  }
}

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
      final result = await platform.invokeMethod(
        'getWeatherFromRust',
        {"city": _controller.text},
      );
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
