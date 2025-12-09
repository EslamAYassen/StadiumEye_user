import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> cacheToken(String token);
  Future<UserModel?> getCachedUser();
  Future<String?> getCachedToken();
  Future<void> clearCache();
}
