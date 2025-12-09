import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entites/home_data_entity.dart';

import '../repositories/home_repo.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, HomeDataEntity>> call() {
    return repository.getHomeData();
  }
}
