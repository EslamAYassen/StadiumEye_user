import 'creator_entity.dart';
import 'stadium_entity.dart';
import 'text_detection_entity.dart';
import 'ticket_detection_entity.dart';

class TicketEntity {
  final String id;
  final CreatorEntity? createdBy;
  final StadiumEntity stadium;
  final String area;
  final String ticketType;
  final String status;
  final String observations;
  final String challenges;
  final String lessonsLearned;
  final List<String> ticketVideos;
  final List<String> ticketImages;
  final List<String> ticketVoices;
  final String priority;
  final String visibility;
  final DateTime createdAt;

  // AI-related / extended fields
  final String? stadiumStatus;
  final String mode;
  final DateTime? updatedAt;
  final List<String> recommendations;
  final List<TicketDetectionEntity> ticketDetections;
  final String? department;
  final double? confidence;
  final TextDetectionEntity? textDetection;

  TicketEntity({
    required this.id,
    this.createdBy,
    required this.stadium,
    required this.area,
    required this.ticketType,
    required this.status,
    required this.observations,
    required this.challenges,
    required this.lessonsLearned,
    required this.ticketVideos,
    required this.ticketImages,
    required this.ticketVoices,
    required this.priority,
    required this.visibility,
    required this.createdAt,
    this.stadiumStatus,
    this.mode = 'manual',
    this.updatedAt,
    this.recommendations = const [],
    this.ticketDetections = const [],
    this.department,
    this.confidence,
    this.textDetection,
  });

  /// Convenience getter: true when this report was analyzed by the AI model
  /// and produced at least one detection.
  bool get hasAiDetections =>
      mode == 'ai' && ticketDetections.any((d) => d.detections.isNotEmpty);

  /// Total number of individual detected objects across all media.
  int get totalDetectionsCount =>
      ticketDetections.fold(0, (sum, d) => sum + d.detections.length);

  /// True when the AI text-classification pipeline produced usable content.
  bool get hasTextDetection =>
      textDetection != null && textDetection!.hasContent;
}
