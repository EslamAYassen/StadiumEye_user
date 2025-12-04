import 'package:flutter/material.dart';
class GeometricLinesPainter extends CustomPainter {
  final Animation<double> animation;

  GeometricLinesPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =  Color.fromRGBO(118, 255, 3, 0.1*animation.value)

      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;


    for (int i = 0; i < 5; i++) {
      final path = Path();
      path.moveTo(size.width * (i / 5), 0);
      path.lineTo(size.width * ((i + 1) / 5), size.height * 0.3);
      path.lineTo(size.width * (i / 5), size.height * 0.6);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}