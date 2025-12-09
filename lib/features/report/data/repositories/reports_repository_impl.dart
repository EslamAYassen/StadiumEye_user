import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../../core/networking/network_info.dart';
import '../../domain/entities/reports_response_entity.dart';
import '../../domain/entities/stadiums_response_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../datasources/reports_remote_datasource.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReportsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReportsResponseEntity>> getMyReports() async {
    if (!await networkInfo.isConnected) {
      return const Left(const NetworkFailure('No internet connection'));
    }

    try {
      final reports = await remoteDataSource.getMyReports();
      return Right(reports);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(const ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, StadiumsResponseEntity>> getStadiums() async {
    if (!await networkInfo.isConnected) {
      return const Left(const NetworkFailure('No internet connection'));
    }

    try {
      final stadiums = await remoteDataSource.getStadiums();
      return Right(stadiums);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(const ServerFailure('An unexpected error occurred'));
    }
  }

  @override
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
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(const NetworkFailure('No internet connection'));
    }

    try {
      final ticket = await remoteDataSource.createReport(
        stadiumId: stadiumId,
        area: area,
        ticketType: ticketType,
        observations: observations,
        challenges: challenges,
        lessonsLearned: lessonsLearned,
        modelType: modelType,
        locationLink: locationLink,
        ticketVideosPaths: ticketVideosPaths,
        ticketImagesPaths: ticketImagesPaths,
        ticketVoicesPaths: ticketVoicesPaths,
      );
      return Right(ticket);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(const ServerFailure('An unexpected error occurred'));
    }
  }
}
