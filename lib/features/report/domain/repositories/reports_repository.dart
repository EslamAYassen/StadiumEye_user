import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/reports_response_entity.dart';
import '../entities/stadiums_response_entity.dart';
import '../entities/ticket_entity.dart';

abstract class ReportsRepository {
  Future<Either<Failure, ReportsResponseEntity>> getMyReports();
  Future<Either<Failure, StadiumsResponseEntity>> getStadiums();
  Future<Either<Failure, TicketEntity>> createReport({
    required String stadiumId,
    required String area,
    required String ticketType,
    required String observations,
    required String challenges,
    required String lessonsLearned,
    String? modelType,
    String? locationLink,
    List<String>? ticketVideosPaths,
    List<String>? ticketImagesPaths,
    List<String>? ticketVoicesPaths,
  });
}
