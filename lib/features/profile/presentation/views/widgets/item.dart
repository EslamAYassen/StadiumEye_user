import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class Item extends StatelessWidget {
  final String title;
  final IconData icon;

  const Item({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: AppColors.lightGreen),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
