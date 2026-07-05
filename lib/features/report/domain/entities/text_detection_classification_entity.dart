/// Classification produced by the AI text-analysis pipeline, derived from
/// the free-text fields the user submits (observations/challenges/etc).
class TextDetectionClassificationEntity {
  final String? category;
  final String? persona;
  final String? interaction;
  final String? department;
  final String? severity;
  final String? priority;
  final String? location;

  TextDetectionClassificationEntity({
    this.category,
    this.persona,
    this.interaction,
    this.department,
    this.severity,
    this.priority,
    this.location,
  });

  bool get isEmpty =>
      category == null &&
      persona == null &&
      interaction == null &&
      department == null &&
      severity == null &&
      priority == null &&
      location == null;
}
