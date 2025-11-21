import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
      title: 'Stadium Eye',
      home: Placeholder(),
    );
  }
}
