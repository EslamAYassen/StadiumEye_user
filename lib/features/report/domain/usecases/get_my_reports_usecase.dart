import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/reports_response_entity.dart';
import '../repositories/reports_repository.dart';

class GetMyReportsUseCase {
  final ReportsRepository repository;

  GetMyReportsUseCase(this.repository);

  Future<Either<Failure, ReportsResponseEntity>> call({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    return await repository.getMyReports(
      page: page,
      limit: limit,
      status: status,
    );
  }
}
