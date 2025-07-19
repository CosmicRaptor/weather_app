import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/city_model.dart';

import '../../core/platform_bridge.dart';
import '../../core/prefs_storage.dart';

class AddCitiesScreen extends ConsumerStatefulWidget {
  const AddCitiesScreen({super.key});

  @override
  ConsumerState<AddCitiesScreen> createState() => _AddCitiesScreenState();
}

class _AddCitiesScreenState extends ConsumerState<AddCitiesScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<CityModel> _suggestions = [
    CityModel(name: 'Mumbai', country: 'India'),
    CityModel(name: 'New York', country: 'USA'),
    CityModel(name: 'Tokyo', country: 'Japan'),
    CityModel(name: 'London', country: 'UK'),
    CityModel(name: 'Sydney', country: 'Australia'),
  ];

  List<CityModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _suggestions;
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _controller.text;
    if (query.length < 2) {
      setState(() => _filtered = []);
      return;
    }

    RustBridge.searchCities(query).then((cities) {
      if (mounted) {
        setState(() {
          _filtered = cities;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedCitiesAsync = ref.watch(savedCitiesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Cities')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Lottie Animation
            Lottie.asset(
              'assets/animations/location.json',
              width: MediaQuery.of(context).size.width * 0.85,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const SizedBox(height: 16),

            // Search field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search City',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Autocomplete list
            Expanded(
              child: savedCitiesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error loading saved cities')),
                data: (savedCities) {
                  return ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final city = _filtered[index];
                      final isSaved = savedCities.contains(city.name);

                      return ListTile(
                        title: Text('${city.name}, ${city.country}'),
                        trailing: IconButton(
                          icon: Icon(isSaved ? Icons.remove_circle_outline : Icons.add_circle_outline),
                          color: isSaved ? Colors.red : Colors.green,
                          onPressed: () async {
                            if (isSaved) {
                              await removeCity(ref, city.name);
                            } else {
                              await saveCity(ref, city.name);
                            }

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isSaved
                                        ? 'Removed ${city.name} from your cities'
                                        : 'Added ${city.name} to your cities',
                                  ),
                                ),
                              );
                            }

                            _controller.clear();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
