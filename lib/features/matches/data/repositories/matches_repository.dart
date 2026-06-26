import 'package:dartz/dartz.dart';
import 'package:stadium_eye/core/error/failures.dart';
import 'package:stadium_eye/core/networking/network_info.dart';
import 'package:stadium_eye/features/matches/data/datasources/matches_remote_ds.dart';
import 'package:stadium_eye/features/matches/domain/entities/matches_res.dart';

class MatchesRepository {
  final MatchesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MatchesRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, ParantMatchesRes>> getMatches({
    String? date,
    String? league,
    String? season,
    String? team,
    String? timezone,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final matches = await remoteDataSource.getMatches(
        date: date,
        league: league,
        season: season,
        team: team,
        timezone: timezone,
      );
      return Right(matches);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }
}
