import 'package:flutter/material.dart';
import 'package:stadium_eye/theme/app_theme_consts.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final String? value;
  final List<String> stadiums;
  final IconData icon;
  final String initText;
  final Function(String? value) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.title,
    required this.stadiums,
    required this.initText,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.05),
          //   blurRadius: 6,
          //   offset: const Offset(0, 3),
          // ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          disabledHint: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          borderRadius: BorderRadius.circular(AppThemeConsts.radius16lg),
          value: value,
          hint: Row(
            children: [
              Icon(icon, size: 30, color: Colors.grey),
              const SizedBox(width: 8),
              Text(initText, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),

          items: stadiums.map((stadium) {
            return DropdownMenuItem(
              value: stadium,
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 20),
                  const SizedBox(width: 8),
                  Text(stadium),
                ],
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}
