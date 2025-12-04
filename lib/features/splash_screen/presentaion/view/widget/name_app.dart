import 'package:flutter/material.dart';
class NameApp extends StatelessWidget {
  const NameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'StadiumEye',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Color(0xFF76FF03),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Monitoring & Reporting System',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
