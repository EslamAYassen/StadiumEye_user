import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/register_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(RegisterParams params);
  Future<Either<Failure, UserEntity>> verifyEmail(String email, String code);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, String>> verifyResetCode(String email, String code);
  Future<Either<Failure, String>> resetPassword(
    String email,
    String newPassword,
  );
  Future<Either<Failure, UserEntity?>> getCachedUser();
}
