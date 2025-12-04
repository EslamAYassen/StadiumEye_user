import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(118, 255, 3, 0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        //TODO: implement sign in
        onPressed: () =>
            Navigator.pushReplacementNamed(context, AppRoutes.home),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
