import 'package:dio/dio.dart';
import 'package:stadium_eye/core/storage/secure_storage.dart';
import 'endpoints.dart';

class DioClient {
  final storage = SecureStorage();
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: "application/json",
      ),
    );

    return dio;
  }
}
