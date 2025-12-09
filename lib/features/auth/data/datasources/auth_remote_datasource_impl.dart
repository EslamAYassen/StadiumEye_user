import 'package:dio/dio.dart';

import '../../../../core/networking/endpoints.dart';
import '../../domain/usecases/register_usecase.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        AuthEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.data['success'] == true) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<UserModel> register(RegisterParams params) async {
    try {
      final response = await dio.post(
        AuthEndpoints.register,
        data: {
          'firstName': params.firstName,
          'lastName': params.lastName,
          'email': params.email,
          'phone': params.phone,
          if (params.profilePicture != null)
            'profilePicture': params.profilePicture,
          'genderEn': params.genderEn,
          'dateOfBirth': params.dateOfBirth,
          'password': params.password,
          'confirmPassword': params.confirmPassword,
          'city': params.city,
          'country': params.country,
        },
      );

      if (response.data['success'] == true) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<UserModel> verifyEmail(String email, String code) async {
    try {
      final response = await dio.post(
        AuthEndpoints.verifyEmail,
        data: {'email': email, 'code': code},
      );

      if (response.data['success'] == true) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Verification failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(AuthEndpoints.logout);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      final response = await dio.post(
        AuthEndpoints.forgotPassword,
        data: {'email': email},
      );

      if (response.data['success'] == true) {
        return response.data['message'] as String;
      } else {
        throw Exception(response.data['message'] ?? 'Request failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<String> verifyResetCode(String email, String code) async {
    try {
      final response = await dio.post(
        AuthEndpoints.verifyResetCode,
        data: {'email': email, 'code': code},
      );

      if (response.data['success'] == true) {
        return response.data['message'] as String;
      } else {
        throw Exception(response.data['message'] ?? 'Verification failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<String> resetPassword(String email, String newPassword) async {
    try {
      final response = await dio.patch(
        AuthEndpoints.resetPassword,
        data: {
          'email': email,
          'newPassword': newPassword,
          'confirmNewPassword': newPassword,
        },
      );

      if (response.data['success'] == true) {
        return response.data['message'] as String;
      } else {
        throw Exception(response.data['message'] ?? 'Password reset failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      return Exception(message);
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('An unexpected error occurred');
    }
  }
}
