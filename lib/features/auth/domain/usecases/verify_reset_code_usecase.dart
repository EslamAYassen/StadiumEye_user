import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  final AuthRepository repository;

  VerifyResetCodeUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String code) {
    return repository.verifyResetCode(email, code);
  }
}
