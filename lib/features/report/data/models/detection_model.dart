import '../../domain/entities/detection_entity.dart';

class DetectionModel extends DetectionEntity {
  DetectionModel({
    required super.id,
    required super.className,
    required super.confidence,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
  });

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      id: json['Id'] as int? ?? 0,
      className: json['ClassName'] as String? ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
