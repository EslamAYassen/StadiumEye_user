import 'package:flutter/material.dart';
class TitleRepot extends StatelessWidget {
  const TitleRepot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        const Text(
          "Stadium Eye",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Event Monitoring System",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
