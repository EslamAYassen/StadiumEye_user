import 'package:flutter/material.dart';
import 'package:stadium_eye/features/report/presentation/pages/home_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/my_reports_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/report_page.dart';

import '../features/report/presentation/pages/add_report_page.dart';

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
        //TODO: Replace Placeholder with AboutScreen
        return MaterialPageRoute(builder: (_) => const Placeholder());

      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
