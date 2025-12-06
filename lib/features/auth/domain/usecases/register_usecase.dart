import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? profilePicture;
  final String genderEn;
  final String dateOfBirth;
  final String password;
  final String confirmPassword;
  final String city;
  final String country;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profilePicture,
    required this.genderEn,
    required this.dateOfBirth,
    required this.password,
    required this.confirmPassword,
    required this.city,
    required this.country,
  });
}

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return repository.register(params);
  }
}
