import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/countries_response_entity.dart';
import '../repositories/reports_repository.dart';

class GetCountriesUseCase {
  final ReportsRepository repository;

  GetCountriesUseCase(this.repository);

  Future<Either<Failure, CountriesResponseEntity>> call() {
    return repository.getCountries();
  }
}
