import 'package:flutter/material.dart';
import 'package:stadium_eye/features/auth/presentation/view/login_screen.dart';
import 'package:stadium_eye/features/auth/presentation/view/otp_screen.dart';
import 'package:stadium_eye/features/auth/presentation/view/signup_screen.dart';
import 'package:stadium_eye/features/profile/presentation/views/profile_screen.dart';
import 'package:stadium_eye/features/report/presentation/pages/home_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/my_reports_page.dart';
import 'package:stadium_eye/features/report/presentation/pages/report_page.dart';
import 'package:stadium_eye/features/splash_screen/presentaion/view/splash_screen.dart';
import '../features/about_us/presentation/about_us_page.dart';
import '../features/navigator/navigator_page.dart';
import '../features/report/presentation/pages/add_report_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';

abstract class AppRoutes {
  const AppRoutes._();
  static const String navigator = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/signup';
  static const String otp = '/otp';
  static const String reportDetails = '/reportDetails';
  static const String addReportPage = '/addTicketPage';
  static const String myReports = '/myReports';
  static const String profile = '/profile';
  static const String settingsPage = '/settings';
  static const String about = '/about';
  static const String help = '/help';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case navigator:
        return MaterialPageRoute(builder: (_) => const NavigatorPage());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case otp:
        final email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OtpScreen(email: email));
      case addReportPage:
        return MaterialPageRoute(builder: (_) => const AddReportPage());
      case myReports:
        return MaterialPageRoute(builder: (_) => const MyReportsPage());
      case reportDetails:
        final data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => ReportPage(data: data));
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
