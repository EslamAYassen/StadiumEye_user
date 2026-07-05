class DetectionEntity {
  final int id;
  final String className;
  final double confidence;
  final double x;
  final double y;
  final double width;
  final double height;

  DetectionEntity({
    required this.id,
    required this.className,
    required this.confidence,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}
