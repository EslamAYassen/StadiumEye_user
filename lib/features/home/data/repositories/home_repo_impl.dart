import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../../core/networking/network_info.dart';
import '../../domain/entites/home_data_entity.dart';

import '../../domain/repositories/home_repo.dart';
import '../datasources/home_remote_ds_impl.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, HomeDataEntity>> getHomeData() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final homeData = await remoteDataSource.getHomeData();

      return Right(homeData.toEntity());
    } on Exception catch (e) {
      // // If remote fails, try cached data
      // try {
      //   final cachedData = await localDataSource.getCachedHomeData();
      //   if (cachedData != null) {
      //     return Right(cachedData.toEntity());
      //   }
      // } catch (_) {}

      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }
}
