import 'package:dio/dio.dart';
import '../../services/session_expired_notifier.dart';
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
    // Token is invalid or expired. Notify the app so AuthBloc can clear the
    // cached session and redirect to the login screen, instead of silently
    // swallowing the 401 and showing the same "session expired" error on
    // every future app launch.
    if (err.response?.statusCode == 401) {
      SessionExpiredNotifier.instance.notify();
    }

    handler.next(err);
  }
}
