import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.logout, color: AppColors.lightGreen),
        label: Text('Logout', style: TextStyle(color: AppColors.lightGreen)),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 45),
          side: const BorderSide(color:AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
