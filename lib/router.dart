import 'package:go_router/go_router.dart';
import 'package:weather_app/screens/add_cities_screen/add_cities_screen.dart';
import 'package:weather_app/screens/home_screen/home_screen.dart';
import 'package:weather_app/screens/onboarding_screen/location_permission_screen.dart';
import 'package:weather_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:weather_app/screens/splash_screen/splash_screen.dart';

final routerConf = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/location-permission',
      builder: (context, state) => const LocationPermissionScreen(),
    ),
    GoRoute(
      path: '/add-city',
      builder: (context, state) => const AddCitiesScreen(),
    ),
  ],
);