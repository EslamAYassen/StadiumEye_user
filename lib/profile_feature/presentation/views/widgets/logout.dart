import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.logout, color: Colors.green[900]),
        label: Text('Logout', style: TextStyle(color: Colors.green[900])),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 45),
          side: const BorderSide(color: Colors.green),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
