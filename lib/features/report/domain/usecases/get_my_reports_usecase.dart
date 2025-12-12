import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/reports_response_entity.dart';
import '../repositories/reports_repository.dart';

class GetMyReportsUseCase {
  final ReportsRepository repository;

  GetMyReportsUseCase(this.repository);

  Future<Either<Failure, ReportsResponseEntity>> call() {
    return repository.getMyReports();
  }
}
