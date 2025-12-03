import 'package:flutter/material.dart';

class MissionStatement extends StatelessWidget {
  const MissionStatement({super.key, required this.missionOpacity});
  final double missionOpacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: missionOpacity,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00D856), Color(0xFF00B347)],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 216, 86, 0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: const Column(
          children: [
            Icon(Icons.emoji_events, color: Colors.white, size: 50),
            SizedBox(height: 15),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'To revolutionize stadium management through innovative reporting and real-time insights for a better experience.',
              style: TextStyle(fontSize: 15, color: Colors.white, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
