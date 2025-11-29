// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stadium_eye/constants/app_routes.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        _ActionButton(
          onTap: () => Navigator.pushNamed(context, AppRoutes.addReportPage),
          textColor: Colors.white,
          icon: Iconsax.add_copy,
          gradientColors: const [Color(0xFF00c951), Color(0xFF00bd7e)],
          title: "Create Report",
          subtitle: "Report an issue quickly",
        ),

        const SizedBox(height: 30),

        _ActionButton(
          textColor: Colors.black,
          onTap: () => Navigator.pushNamed(context, AppRoutes.myReports),
          icon: Iconsax.document_copy,
          title: "My Reports",
          subtitle: "View your submitted reports",
          iconColor: Colors.green,
          fontWeight: FontWeight.w400,
          gradientColors: const [Color(0xFFE8FFF1)],
          iconBackgroundColor: Colors.white,
          numberOfReports: 23,
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String subtitle;
  final Color textColor;
  final FontWeight fontWeight;
  final int? numberOfReports;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const _ActionButton({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.white24,
    required this.title,
    required this.subtitle,
    required this.textColor,
    this.fontWeight = FontWeight.bold,
    this.numberOfReports,
    this.onTap,
    this.gradientColors = const [Color(0xFF00C16E), Color(0xFF4BE596)],
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _scale = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.gradientColors.length != 1
                    ? null
                    : widget.gradientColors[0],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 14,
                    offset: Offset(0, 2),
                  ),
                ],
                gradient: widget.gradientColors.length == 1
                    ? null
                    : LinearGradient(colors: widget.gradientColors),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: widget.iconBackgroundColor,
                    child: Icon(widget.icon, size: 30, color: widget.iconColor),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: 18,
                          fontWeight: widget.fontWeight,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: TextStyle(color: widget.textColor, fontSize: 14),
                      ),
                    ],
                  ),
                  if (widget.numberOfReports != null) ...[
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        widget.numberOfReports.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
