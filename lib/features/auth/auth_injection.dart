// ==================== DEPENDENCY INJECTION ====================

// lib/features/auth/auth_injection.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import '../../core/network/dio_client.dart';
// import '../../core/network/network_info.dart';
import '../../core/networking/dio_client.dart';
import '../../core/networking/interceptors/auth_interceptor.dart';
import '../../core/networking/network_info.dart';
import '../../core/storage/secure_storage.dart';

import 'data/datasources/auth_local_datasource.dart';
import 'data/datasources/auth_local_datasource_impl.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/forgot_password_usecase.dart';
import 'domain/usecases/get_cached_user_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/verify_email_usecase.dart';
import 'domain/usecases/verify_reset_code_usecase.dart';

import 'presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initAuthDependencies() async {
  // ==================== Bloc ====================
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      verifyEmailUseCase: sl(),
      logoutUseCase: sl(),
      getCachedUserUseCase: sl(),
      forgotPasswordUseCase: sl(),
      verifyResetCodeUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );

  // ==================== Use Cases ====================
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyResetCodeUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  // ==================== Repository ====================
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // ==================== Data Sources ====================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // ==================== Core ====================
  // Dio Client with Auth Interceptor
  sl.registerLazySingleton<Dio>(() {
    final dio = DioClient.create();
    dio.interceptors.add(AuthInterceptor(sl()));
    return dio;
  });

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Internet Connection Checker
  sl.registerLazySingleton(() => InternetConnection());

  // Secure Storage
  sl.registerLazySingleton(() => SecureStorage());
}
