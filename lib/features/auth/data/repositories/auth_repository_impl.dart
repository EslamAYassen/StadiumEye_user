import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../../core/networking/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_usecase.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final user = await remoteDataSource.login(email, password);

      // Cache user and token
      await localDataSource.cacheUser(user);
      if (user.token != null) {
        await localDataSource.cacheToken(user.token!);
      }

      return Right(user.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final user = await remoteDataSource.register(params);

      // Don't cache here because user needs to verify email first
      return Right(user.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyEmail(
    String email,
    String code,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final user = await remoteDataSource.verifyEmail(email, code);

      // Cache user and token after successful verification
      await localDataSource.cacheUser(user);
      if (user.token != null) {
        await localDataSource.cacheToken(user.token!);
      }

      return Right(user.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Try to logout from server if connected
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.logout();
        } catch (e) {
          // Continue even if server logout fails
        }
      }

      // Always clear local cache
      await localDataSource.clearCache();
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(CacheFailure('Failed to logout'));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final message = await remoteDataSource.forgotPassword(email);
      return Right(message);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> verifyResetCode(
    String email,
    String code,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final message = await remoteDataSource.verifyResetCode(email, code);
      return Right(message);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
    String email,
    String newPassword,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final message = await remoteDataSource.resetPassword(email, newPassword);
      return Right(message);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() async {
    try {
      final user = await localDataSource.getCachedUser();
      return Right(user?.toEntity());
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString().replaceAll('Exception: ', '')));
    } catch (e) {
      return const Left(CacheFailure('Failed to get cached user'));
    }
  }
}
