import 'package:dio/dio.dart';
import '../../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  AuthInterceptor(this.secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read("token");

    if (token != null) {
      options.headers["Authorization"] = token;
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized errors (token expired or invalid)
    if (err.response?.statusCode == 401) {
      // Token is invalid or expired
      // You might want to clear the token and redirect to login
      // secureStorage.delete("token");
    }

    handler.next(err);
  }
}
