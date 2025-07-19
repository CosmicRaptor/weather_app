import 'package:flutter/foundation.dart';

void debugPrint(String message) {
  final timestamp = DateTime.now().toIso8601String();
  if (kDebugMode) {
    print('[$timestamp] $message');
  }
}
