import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.register),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
