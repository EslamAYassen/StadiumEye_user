import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/l10n/app_localizations.dart';

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
        child: Column(
          children: [
            const Icon(Iconsax.award_copy, color: Colors.white, size: 50),
            const SizedBox(height: 15),
            Text(
              AppLocalizations.of(context)!.ourMission,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.ourMissionDescription,
              //   'To revolutionize stadium management through innovative reporting and real-time insights for a better experience.',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
