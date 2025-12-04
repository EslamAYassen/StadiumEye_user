import 'package:flutter/material.dart';
class GlowingCircle extends StatelessWidget {
  const GlowingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:const Color(0xFF76FF03),
          width: 3,
        ),
        boxShadow: [
         const BoxShadow(
            color: Color.fromRGBO(118, 255, 3, 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
