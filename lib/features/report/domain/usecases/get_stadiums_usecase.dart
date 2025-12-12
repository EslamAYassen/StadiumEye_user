import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/stadiums_response_entity.dart';
import '../repositories/reports_repository.dart';

class GetStadiumsUseCase {
  final ReportsRepository repository;

  GetStadiumsUseCase(this.repository);

  Future<Either<Failure, StadiumsResponseEntity>> call() {
    return repository.getStadiums();
  }
}
