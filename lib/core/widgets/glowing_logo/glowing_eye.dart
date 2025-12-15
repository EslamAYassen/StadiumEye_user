import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GlowingEye extends StatelessWidget {
  const GlowingEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Color(0xFF76FF03), Color(0xFF2E7D32)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(118, 255, 3, 0.6),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: const Icon(Iconsax.eye_copy, size: 60, color: Colors.white),
    );
  }
}
