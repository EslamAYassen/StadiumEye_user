import '../../domain/entities/ticket_entity.dart';
import 'creator_model.dart';
import 'stadium_model.dart';

class TicketModel extends TicketEntity {
  TicketModel({
    required super.id,
    super.createdBy,
    required super.stadium,
    required super.area,
    required super.ticketType,
    required super.status,
    required super.observations,
    required super.challenges,
    required super.lessonsLearned,
    required super.ticketVideos,
    required super.ticketImages,
    required super.ticketVoices,
    required super.priority,
    required super.visibility,
    required super.createdAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['_id'] as String,
      createdBy: json['createdBy'] != null
          ? CreatorModel.fromJson(json['createdBy'] as Map<String, dynamic>)
          : null,
      stadium: StadiumModel.fromJson(json['stadium'] as Map<String, dynamic>),
      area: json['area'] as String,
      ticketType: json['ticketType'] as String,
      status: json['status'] as String,
      observations: json['observations'] as String,
      challenges: json['challenges'] as String? ?? '',
      lessonsLearned: json['lessonsLearned'] as String? ?? '',
      ticketVideos: (json['ticketVideos'] as List?)?.cast<String>() ?? [],
      ticketImages: (json['ticketImages'] as List?)?.cast<String>() ?? [],
      ticketVoices: (json['ticketVoices'] as List?)?.cast<String>() ?? [],
      priority: json['priority'] as String? ?? 'medium',
      visibility: json['visibility'] as String? ?? 'public',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
