import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationState {
  final Position? position;
  final String? city;

  LocationState({this.position, this.city});

  LocationState copyWith({Position? position, String? city}) {
    return LocationState(
      position: position ?? this.position,
      city: city ?? this.city,
    );
  }
}

class LocationNotifier extends StateNotifier<AsyncValue<LocationState>> {
  LocationNotifier() : super(AsyncValue.data(LocationState()));

  Future<void> updateLocation() async {
    state = const AsyncLoading();

    try {
      final position = await determinePosition();
      final city = await getCityFromCoordinates(position);

      final location = LocationState(position: position, city: city);
      state = AsyncData(location);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  /// Get the current city name based on the device's location.
  Future<String?> getCityFromCoordinates(Position position) async {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return placemarks.firstOrNull?.locality ?? 'Mumbai';
  }
}

final LocationSettings _locationSettings = LocationSettings(
  accuracy: LocationAccuracy.low,
  distanceFilter: 10000,
);
AutoDisposeStreamProvider<Position> positionStream =
    StreamProvider.autoDispose<Position>(
      (ref) =>
          Geolocator.getPositionStream(locationSettings: _locationSettings),
    );

final locationProvider =
    StateNotifierProvider<LocationNotifier, AsyncValue<LocationState>>(
      (ref) => LocationNotifier(),
    );
