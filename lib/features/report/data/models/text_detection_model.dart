import '../../domain/entities/text_detection_entity.dart';
import 'text_detection_classification_model.dart';

class TextDetectionModel extends TextDetectionEntity {
  TextDetectionModel({
    super.ticketId,
    super.status,
    super.error,
    super.classification,
    super.summary,
    super.extractedText,
  });

  factory TextDetectionModel.fromJson(Map<String, dynamic> json) {
    return TextDetectionModel(
      ticketId: json['ticketId'] as String?,
      status: textDetectionStatusFromString(json['status'] as String?),
      error: json['error'] as String?,
      classification: json['classification'] != null
          ? TextDetectionClassificationModel.fromJson(
              json['classification'] as Map<String, dynamic>,
            )
          : null,
      summary: json['summary'] as String?,
      extractedText: json['extractedText'] as String?,
    );
  }
}
