import '../../domain/entities/report_entity.dart';

class ReportModel extends ReportEntity {
  ReportModel({
    required super.stadiumId,
    required super.ticketType,
    required super.title,
    required super.description,
    required super.priority,
    required super.visibility,
    required super.location,
    required super.manualEntry,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      stadiumId: json["stadium_id"],
      ticketType: json["ticket_type"],
      title: json["title"],
      description: json["description"],
      priority: json["priority"],
      visibility: json["visibility"],
      location: json["location"],
      manualEntry: json["manual_entry"],
    );
  }

  Map<String, dynamic> toJson() => {
    "stadium_id": stadiumId,
    "ticket_type": ticketType,
    "title": title,
    "description": description,
    "priority": priority,
    "visibility": visibility,
    "location": location,
    "manual_entry": manualEntry,
  };
}
