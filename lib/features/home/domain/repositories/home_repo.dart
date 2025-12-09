import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entites/home_data_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeDataEntity>> getHomeData();
}
