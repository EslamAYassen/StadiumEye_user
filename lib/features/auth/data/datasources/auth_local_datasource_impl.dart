import 'dart:convert';

import '../../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';
import 'auth_local_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage secureStorage;

  static const String userKey = 'cached_user';
  static const String tokenKey = 'token';

  AuthLocalDataSourceImpl(this.secureStorage);

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await secureStorage.write(userKey, userJson);
    } catch (e) {
      throw Exception('Failed to cache user: $e');
    }
  }

  @override
  Future<void> cacheToken(String token) async {
    try {
      await secureStorage.write(tokenKey, token);
    } catch (e) {
      throw Exception('Failed to cache token: $e');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = await secureStorage.read(userKey);
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get cached user: $e');
    }
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      return await secureStorage.read(tokenKey);
    } catch (e) {
      throw Exception('Failed to get cached token: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await secureStorage.delete(userKey);
      await secureStorage.delete(tokenKey);
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }
}
