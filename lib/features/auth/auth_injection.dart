import 'package:get_it/get_it.dart';

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
}
