// ==================== DEPENDENCY INJECTION ====================

// lib/features/home/home_injection.dart
import 'package:get_it/get_it.dart';

import 'data/datasources/home_remote_ds_impl.dart';
import 'data/repositories/home_repo_impl.dart';

import 'domain/repositories/home_repo.dart';

import 'domain/usecases/get_home_usecase.dart';
import 'presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initHomeDependencies() async {
  // ==================== Bloc ====================
  sl.registerFactory(() => HomeBloc(getHomeDataUseCase: sl()));

  // ==================== Use Cases ====================
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  // ==================== Repository ====================
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      // localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // ==================== Data Sources ====================
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );

  // sl.registerLazySingleton<HomeLocalDataSource>(
  //   () => HomeLocalDataSourceImpl(sl()),
  // );
}
