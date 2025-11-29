import 'package:flutter/material.dart';
class LoginBoutton extends StatelessWidget {
  const LoginBoutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C26F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Sign In",
          style: TextStyle(
              fontSize: 16, color: Colors.white, height: 1.2),
        ),
      ),
    );
  }
}
