import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/pages/home_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/my_reports_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/report_page.dart';
import '../features/about_us/presentation/about_us_page.dart';
import '../features/report/presentation/pages/add_report_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';

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
  static const String settingsPage = '/settings';
  static const String about = '/about';
  static const String help = '/help';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        //TODO: Replace Placeholder with HomeScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case register:
        //TODO: Replace Placeholder with RegisterScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case addReportPage:
        return MaterialPageRoute(builder: (_) => const AddReportPage());
      case myReports:
        return MaterialPageRoute(builder: (_) => const MyReportsPage());
      case reportDetails:
        final data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => ReportPage(data: data));
      case profile:
        //TODO: Replace Placeholder with ProfileScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
