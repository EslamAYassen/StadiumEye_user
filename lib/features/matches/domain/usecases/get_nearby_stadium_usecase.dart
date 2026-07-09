import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/matches_repository.dart';
import '../entities/nearby_stadium_res.dart';

class GetNearbyStadiumUseCase {
  final MatchesRepository repository;

  GetNearbyStadiumUseCase(this.repository);

  Future<Either<Failure, NearbyStadiumDataEntity>> call({
    required double lat,
    required double lng,
  }) {
    return repository.getNearbyStadium(lat: lat, lng: lng);
  }
}
