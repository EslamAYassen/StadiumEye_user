import 'package:flutter/material.dart';

class AnimatedUpArrows extends StatefulWidget {
  const AnimatedUpArrows({super.key});

  @override
  State<AnimatedUpArrows> createState() => _AnimatedUpArrowsState();
}

class _AnimatedUpArrowsState extends State<AnimatedUpArrows>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: 60,
          height: 80,
          child: Stack(
            children: [
              _buildArrow(0, _animation.value),
              _buildArrow(1, (_animation.value + 0.33) % 1),
              _buildArrow(2, (_animation.value + 0.66) % 1),
            ],
          ),
        );
      },
    );
  }

  Widget _buildArrow(int index, double progress) {
    final double opacity = (1 - progress).clamp(0.0, 1.0);
    final double yOffset = progress * 30;

    return Positioned(
      top: 10 + (index * 20) + yOffset,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: opacity,
        child: CustomPaint(size: const Size(60, 20), painter: ArrowPainter()),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(5, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width - 5, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
