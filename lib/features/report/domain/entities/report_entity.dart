class ReportEntity {
  final String stadiumId;
  final String ticketType;
  final String title;
  final String description;
  final String priority;
  final String visibility;
  final Map<String, dynamic> location;
  final Map<String, dynamic> manualEntry;

  ReportEntity({
    required this.stadiumId,
    required this.ticketType,
    required this.title,
    required this.description,
    required this.priority,
    required this.visibility,
    required this.location,
    required this.manualEntry,
  });
}
