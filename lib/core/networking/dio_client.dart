import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stadium_eye/core/storage/secure_storage.dart';
import 'endpoints.dart';
import 'interceptors/auth_interceptor.dart';

class DioClient {
  final storage = SecureStorage();
  static Dio create() {
    final storage = SecureStorage();
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: "application/json",
      ),
    );
    // Add logging interceptor (only in debug mode)
    // if (kDebugMode) {
    //   dio.interceptors.add(
    //     LogInterceptor(
    //       requestHeader: true,
    //       requestBody: true,
    //       responseHeader: true,
    //       responseBody: true,
    //       error: true,
    //       request: true,
    //       logPrint: (obj) {
    //         if (kDebugMode) {
    //           print('📡 [DIO] $obj');
    //         }
    //       },
    //     ),
    //   );
    // }
    dio.interceptors.add(AuthInterceptor(storage));
    return dio;
  }
}
