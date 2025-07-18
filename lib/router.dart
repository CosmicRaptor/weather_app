import 'package:go_router/go_router.dart';
import 'package:weather_app/screens/home_screen/home_screen.dart';
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
    )
  ],
);