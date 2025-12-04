import 'package:flutter/material.dart';
class TextTitle2 extends StatelessWidget {
  const TextTitle2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Create Account',
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
          'Join Stadium Eye',
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
