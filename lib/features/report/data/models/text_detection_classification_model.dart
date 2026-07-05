import '../../domain/entities/text_detection_classification_entity.dart';

class TextDetectionClassificationModel
    extends TextDetectionClassificationEntity {
  TextDetectionClassificationModel({
    super.category,
    super.persona,
    super.interaction,
    super.department,
    super.severity,
    super.priority,
    super.location,
  });

  factory TextDetectionClassificationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TextDetectionClassificationModel(
      category: json['category'] as String?,
      persona: json['persona'] as String?,
      interaction: json['interaction'] as String?,
      department: json['department'] as String?,
      severity: json['severity'] as String?,
      priority: json['priority'] as String?,
      location: json['location'] as String?,
    );
  }
}
