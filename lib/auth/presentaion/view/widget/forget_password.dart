import 'package:flutter/material.dart';
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child:const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
