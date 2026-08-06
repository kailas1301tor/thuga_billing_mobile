import 'package:flutter/material.dart';

import '../../src/auth/view/login_screen.dart';
import '../../src/auth/view/register_screen.dart';
import '../../src/splash/view/splash_screen.dart';
import 'route_constants.dart';

/// Legacy route generator — superseded by [appRouter].
/// Kept for reference; [ThugaApp] uses `MaterialApp.router` with go_router.
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.routeSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case RouteConstants.routeLoginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case RouteConstants.routeRegisterScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );

      case RouteConstants.routeHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Use go_router shell routes')),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
