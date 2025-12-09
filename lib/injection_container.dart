// lib/injection_container.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/networking/dio_client.dart';
import 'core/networking/network_info.dart';
import 'core/storage/secure_storage.dart';
import 'features/auth/auth_injection.dart';
import 'features/home/home_injection.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ==================== Core Dependencies ====================

  // Secure Storage
  sl.registerLazySingleton(() => SecureStorage());

  // Internet Connection Checker
  sl.registerLazySingleton(() => InternetConnection());

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Dio Client (with Auth Interceptor)
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // ==================== Feature Dependencies ====================

  // Initialize Auth feature
  await initAuthDependencies();

  // Initialize Home feature
  await initHomeDependencies();
}
