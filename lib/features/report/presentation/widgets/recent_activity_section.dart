import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15),
        _RecentActivityItem(
          title: "Report submitted",
          subtitle: "King Fahd Stadium - North Stand",
          timeAgo: "2 hours ago",
        ),
        _RecentActivityItem(
          title: "Photo captured",
          subtitle: "Al Janoub Stadium - West Entrance",
          timeAgo: "5 hours ago",
          icon: Iconsax.camera,
        ),
        _RecentActivityItem(
          title: "Report submitted",
          subtitle: "Education City Stadium - East Stand",
          timeAgo: "1 day ago",
        ),
      ],
    );
  }
}

class _RecentActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;

  const _RecentActivityItem({
    // super.key,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.icon = Iconsax.document,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE6FFF2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF00C16E), size: 28),
          ),

          const SizedBox(width: 16),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                ),
                const SizedBox(height: 6),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00C16E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
