import 'package:flutter/material.dart';
class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Stadium Eye',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Color(0xFF76FF03),
                blurRadius: 20,
              ),
              Shadow(
                color: Color.fromRGBO(118, 255, 3, 0.6),
                blurRadius: 40,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Event Monitoring System',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
