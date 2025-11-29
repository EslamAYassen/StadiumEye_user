import 'package:flutter/material.dart';
class SignUpBoutton extends StatelessWidget {
  const SignUpBoutton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          InkWell(
            onTap: () {},
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
