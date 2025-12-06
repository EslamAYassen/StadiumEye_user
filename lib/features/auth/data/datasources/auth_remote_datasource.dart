import '../../domain/usecases/register_usecase.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(RegisterParams params);
  Future<UserModel> verifyEmail(String email, String code);
  Future<void> logout();
  Future<String> forgotPassword(String email);
  Future<String> verifyResetCode(String email, String code);
  Future<String> resetPassword(String email, String newPassword);
}
