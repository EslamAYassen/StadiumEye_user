import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../domain/entities/detection_entity.dart';

/// Paints bounding boxes + labels for a list of [DetectionEntity] over an
/// image of known intrinsic [imageWidth]/[imageHeight], scaling the raw
/// pixel coordinates returned by the AI model to the rendered widget size.
class DetectionOverlayPainter extends CustomPainter {
  final List<DetectionEntity> detections;
  final double imageWidth;
  final double imageHeight;
  final int? highlightedIndex;

  DetectionOverlayPainter({
    required this.detections,
    required this.imageWidth,
    required this.imageHeight,
    this.highlightedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (imageWidth <= 0 || imageHeight <= 0) return;

    final scaleX = size.width / imageWidth;
    final scaleY = size.height / imageHeight;

    for (var i = 0; i < detections.length; i++) {
      final detection = detections[i];
      final isHighlighted = highlightedIndex == null || highlightedIndex == i;

      final rect = Rect.fromLTWH(
        detection.x * scaleX,
        detection.y * scaleY,
        detection.width * scaleX,
        detection.height * scaleY,
      );

      final color = _colorForClass(detection.className);

      final boxPaint = Paint()
        ..color = isHighlighted ? color : color.withAlpha(60)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isHighlighted ? 3 : 1.5;

      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(6));
      canvas.drawRRect(rrect, boxPaint);

      if (isHighlighted) {
        final fillPaint = Paint()..color = color.withAlpha(30);
        canvas.drawRRect(rrect, fillPaint);

        // Label chip
        final labelText =
            '${detection.className} ${(detection.confidence * 100).toStringAsFixed(0)}%';
        final textPainter = TextPainter(
          text: TextSpan(
            text: labelText,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        final labelPadding = 6.0;
        final labelHeight = textPainter.height + labelPadding;
        final labelWidth = textPainter.width + labelPadding * 2;

        final labelTop = rect.top - labelHeight < 0 ? rect.top : rect.top - labelHeight;
        final labelRect = Rect.fromLTWH(
          rect.left,
          labelTop,
          labelWidth,
          labelHeight,
        );

        final labelPaint = Paint()..color = color;
        canvas.drawRRect(
          RRect.fromRectAndCorners(
            labelRect,
            topLeft: const Radius.circular(4),
            topRight: const Radius.circular(4),
            bottomRight: const Radius.circular(4),
          ),
          labelPaint,
        );

        textPainter.paint(
          canvas,
          Offset(labelRect.left + labelPadding / 2, labelRect.top + labelPadding / 2),
        );
      }
    }
  }

  Color _colorForClass(String className) {
    switch (className.toUpperCase()) {
      case 'GRAFFITI':
        return AppColors.warning;
      case 'GARBAGE':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  @override
  bool shouldRepaint(covariant DetectionOverlayPainter oldDelegate) {
    return oldDelegate.detections != detections ||
        oldDelegate.imageWidth != imageWidth ||
        oldDelegate.imageHeight != imageHeight ||
        oldDelegate.highlightedIndex != highlightedIndex;
  }
}
