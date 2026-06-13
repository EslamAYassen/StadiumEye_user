import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ticket_entity.dart';
import '../repositories/reports_repository.dart';

class CreateReportParams {
  final String stadiumId;
  final String area;
  final String ticketType;
  final String observations;
  final String challenges;
  final String lessonsLearned;
  final String? modelType;
  final String? locationLink;
  final bool mode;
  final List<String>? ticketVideosPaths;
  final List<String>? ticketImagesPaths;
  final List<String>? ticketVoicesPaths;

  CreateReportParams({
    required this.stadiumId,
    required this.area,
    required this.ticketType,
    required this.observations,
    required this.challenges,
    required this.lessonsLearned,
    required this.mode,
    this.modelType,
    this.locationLink,
    this.ticketVideosPaths,
    this.ticketImagesPaths,
    this.ticketVoicesPaths,
  });
}

class CreateReportUseCase {
  final ReportsRepository repository;

  CreateReportUseCase(this.repository);

  Future<Either<Failure, TicketEntity>> call(CreateReportParams params) {
    return repository.createReport(
      stadiumId: params.stadiumId,
      area: params.area,
      ticketType: params.ticketType,
      observations: params.observations,
      challenges: params.challenges,
      lessonsLearned: params.lessonsLearned,
      modelType: params.modelType,
      locationLink: params.locationLink,
      ticketVideosPaths: params.ticketVideosPaths,
      ticketImagesPaths: params.ticketImagesPaths,
      ticketVoicesPaths: params.ticketVoicesPaths,
      mode: params.mode,
    );
  }
}
