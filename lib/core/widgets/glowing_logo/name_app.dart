import 'package:flutter/material.dart';

class NameApp extends StatelessWidget {
  const NameApp({super.key, this.color = Colors.white});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'StadiumEye',
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [const Shadow(color: Color(0xFF76FF03), blurRadius: 10)],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
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
