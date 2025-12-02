import 'package:flutter/material.dart';
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {

        },
        icon:const Icon(Icons.logout, color: Color(0xFF2E7D32)),
        label:const Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          padding:const EdgeInsets.symmetric(vertical: 16.0),
          side:const BorderSide(color: Color(0xFF2E7D32), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }
}
