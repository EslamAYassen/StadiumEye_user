import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
      theme: AppTheme.mainTheme,
      title: 'Stadium Eye',
      home: const Placeholder(),
    );
  }
}
