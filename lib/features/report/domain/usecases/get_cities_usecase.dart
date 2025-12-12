import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cities_response_entity.dart';
import '../repositories/reports_repository.dart';

class GetCitiesUseCase {
  final ReportsRepository repository;

  GetCitiesUseCase(this.repository);

  Future<Either<Failure, CitiesResponseEntity>> call() {
    return repository.getCities();
  }
}
