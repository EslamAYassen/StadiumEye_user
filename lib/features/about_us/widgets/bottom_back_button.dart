import 'package:flutter/material.dart';
import 'package:stadium_eye/constants/app_routes.dart';

class BottomBackButton extends StatelessWidget {
  const BottomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 216, 86, 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.login);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D856),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, size: 26),
            SizedBox(width: 12),
            Text(
              'Back to Sign In',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
