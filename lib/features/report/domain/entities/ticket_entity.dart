import 'creator_entity.dart';
import 'stadium_entity.dart';

class TicketEntity {
  final String id;
  final CreatorEntity? createdBy;
  final StadiumEntity stadium;
  final String area;
  // final String ticketType;
  final String status;
  final String observations;
  // final String challenges;
  // final String lessonsLearned;
  final List<String> ticketVideos;
  final List<String> ticketImages;
  final List<String> ticketVoices;
  final String priority;
  final String visibility;
  final DateTime createdAt;

  TicketEntity({
    required this.id,
    this.createdBy,
    required this.stadium,
    required this.area,
    // required this.ticketType,
    required this.status,
    required this.observations,
    // required this.challenges,
    // required this.lessonsLearned,
    required this.ticketVideos,
    required this.ticketImages,
    required this.ticketVoices,
    required this.priority,
    required this.visibility,
    required this.createdAt,
  });
}
