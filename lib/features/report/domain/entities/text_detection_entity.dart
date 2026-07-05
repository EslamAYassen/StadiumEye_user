import 'text_detection_classification_entity.dart';

/// Status of the asynchronous AI text-analysis job that classifies the
/// free-text content of a report (observations/challenges/lessonsLearned).
enum TextDetectionStatus { pending, processing, completed, failed, unknown }

TextDetectionStatus textDetectionStatusFromString(String? value) {
  switch (value) {
    case 'pending':
      return TextDetectionStatus.pending;
    case 'processing':
      return TextDetectionStatus.processing;
    case 'completed':
      return TextDetectionStatus.completed;
    case 'failed':
      return TextDetectionStatus.failed;
    default:
      return TextDetectionStatus.unknown;
  }
}

class TextDetectionEntity {
  final String? ticketId;
  final TextDetectionStatus status;
  final String? error;
  final TextDetectionClassificationEntity? classification;
  final String? summary;
  final String? extractedText;

  TextDetectionEntity({
    this.ticketId,
    this.status = TextDetectionStatus.unknown,
    this.error,
    this.classification,
    this.summary,
    this.extractedText,
  });

  bool get isCompleted => status == TextDetectionStatus.completed;
  bool get isFailed => status == TextDetectionStatus.failed;
  bool get isInProgress =>
      status == TextDetectionStatus.pending ||
      status == TextDetectionStatus.processing;

  bool get hasContent =>
      (classification != null && !classification!.isEmpty) ||
      (summary != null && summary!.trim().isNotEmpty) ||
      (extractedText != null && extractedText!.trim().isNotEmpty);
}
