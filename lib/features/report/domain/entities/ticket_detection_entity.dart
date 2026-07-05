import 'detection_entity.dart';

class TicketDetectionEntity {
  final String url;
  final String type;
  final String modelType;
  final List<DetectionEntity> detections;

  TicketDetectionEntity({
    required this.url,
    required this.type,
    required this.modelType,
    required this.detections,
  });
}
