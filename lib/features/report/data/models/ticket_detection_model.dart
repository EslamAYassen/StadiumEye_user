import '../../domain/entities/ticket_detection_entity.dart';
import 'detection_model.dart';

class TicketDetectionModel extends TicketDetectionEntity {
  TicketDetectionModel({
    required super.url,
    required super.type,
    required super.modelType,
    required super.detections,
  });

  factory TicketDetectionModel.fromJson(Map<String, dynamic> json) {
    return TicketDetectionModel(
      url: json['url'] as String? ?? '',
      type: json['type'] as String? ?? 'image',
      modelType: json['modelType'] as String? ?? '',
      detections: (json['detections'] as List? ?? [])
          .map((d) => DetectionModel.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}
