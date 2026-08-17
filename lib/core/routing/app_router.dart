import 'package:flutter/material.dart';
import 'package:go_captin/features/onboarding/presentation/views/onboarding_view.dart';

import '../../features/auth/presentation/phone_login_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingView());

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const PhoneLoginScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
