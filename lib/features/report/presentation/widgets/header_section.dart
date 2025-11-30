import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00c951), Color(0xFF00bd7e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.remove_red_eye,
                      color: Color(0xFF02c952),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Welcome back,\nAhmed Al-Salem",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Iconsax.logout_1_copy,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          const Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatCard(
                  title: "Reports",
                  value: "23",
                  icon: Iconsax.document_copy,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: "Active",
                  value: "5",
                  icon: Iconsax.activity_copy,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: "Team",
                  value: "12",
                  icon: Iconsax.people_copy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scale = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  void _onTapDown(TapDownDetails d) => _controller.reverse();
  void _onTapUp(TapUpDetails d) => _controller.forward();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Container(
              // width: 130,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Icon(widget.icon, color: Colors.white, size: 26),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
