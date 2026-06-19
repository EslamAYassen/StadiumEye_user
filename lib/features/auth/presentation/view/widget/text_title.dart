import 'package:flutter/material.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';

class TextTitle2 extends StatelessWidget {
  const TextTitle2({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          locale.createAccount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(color: Color(0xFF76FF03), blurRadius: 20),
              Shadow(color: Color.fromRGBO(118, 255, 3, 0.6), blurRadius: 40),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          locale.joinStadiumEye,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
