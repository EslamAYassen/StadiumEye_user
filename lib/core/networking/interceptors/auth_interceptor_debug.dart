// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import '../../storage/secure_storage.dart';

// class AuthInterceptorDebug extends Interceptor {
//   final SecureStorage secureStorage;

//   AuthInterceptorDebug(this.secureStorage);

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     // Read token from secure storage
//     final token = await secureStorage.read("token");

//     if (kDebugMode) {
//       print('🔑 [AUTH INTERCEPTOR] Reading token from storage...');
//       print('🔑 [AUTH INTERCEPTOR] Token exists: ${token != null}');
//       if (token != null) {
//         print('🔑 [AUTH INTERCEPTOR] Token length: ${token.length}');
//         print(
//           '🔑 [AUTH INTERCEPTOR] Token preview: ${token.substring(0, token.length > 20 ? 20 : token.length)}...',
//         );
//       }
//     }

//     // Add token to headers if it exists
//     if (token != null && token.isNotEmpty) {
//       options.headers["Authorization"] = "Bearer $token";

//       if (kDebugMode) {
//         print('✅ [AUTH INTERCEPTOR] Added Authorization header');
//         print('📋 [AUTH INTERCEPTOR] All headers: ${options.headers}');
//       }
//     } else {
//       if (kDebugMode) {
//         print('⚠️ [AUTH INTERCEPTOR] No token found in storage');
//       }
//     }

//     if (kDebugMode) {
//       print('🌐 [AUTH INTERCEPTOR] Request: ${options.method} ${options.path}');
//     }

//     // Continue with the request
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (kDebugMode) {
//       print('✅ [AUTH INTERCEPTOR] Response: ${response.statusCode}');
//     }
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     if (kDebugMode) {
//       print('❌ [AUTH INTERCEPTOR] Error: ${err.response?.statusCode}');
//       print('❌ [AUTH INTERCEPTOR] Message: ${err.message}');
//       if (err.response?.statusCode == 401) {
//         print(
//           '🚨 [AUTH INTERCEPTOR] Unauthorized! Token might be invalid or expired',
//         );
//       }
//     }

//     // Handle 401 Unauthorized
//     if (err.response?.statusCode == 401) {
//       // Clear invalid token
//       secureStorage.delete("token");
//     }

//     handler.next(err);
//   }
// }
