import 'package:flutter/material.dart';

abstract class AppRoutes {
  const AppRoutes._();
  static const String navigator = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/signup';
  static const String reportDetails = '/reportDetails';
  static const String addReportPage = '/addTicketPage';
  static const String myReports = '/myReports';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String help = '/help';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        //TODO: Replace Placeholder with HomeScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case login:
        //TODO: Replace Placeholder with HomeScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case register:
        //TODO: Replace Placeholder with RegisterScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case addReportPage:
        //TODO: Replace Placeholder with AddTicketPage
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case profile:
        //TODO: Replace Placeholder with ProfileScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case about:
        //TODO: Replace Placeholder with AboutScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());

      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
