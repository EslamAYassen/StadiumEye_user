// lib/features/matches/matches_injection.dart
import '../../core/services/app_location_service.dart';
import '../../injection_container.dart';

import 'data/datasources/matches_remote_ds.dart';
import 'data/repositories/matches_repository.dart';
import 'domain/usecases/get_nearby_stadium_usecase.dart';
import 'presentation/cubit/matches_cubit.dart';
import 'presentation/cubit/nearby_stadium_cubit.dart';

Future<void> initMatchesDependencies() async {
  // Data sources
  sl.registerLazySingleton<MatchesRemoteDataSource>(
    () => MatchesRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<MatchesRepository>(
    () => MatchesRepository(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Bloc
  sl.registerFactory(() => MatchesCubit(getMatches: sl()));

  // // Data sources
  // sl.registerLazySingleton<MatchesRemoteDataSource>(
  //   () => MatchesRemoteDataSourceImpl(sl()),
  // );

  // // Repository
  // sl.registerLazySingleton<MatchesRepository>(
  //   () => MatchesRepository(remoteDataSource: sl(), networkInfo: sl()),
  // );

  // // Bloc
  // sl.registerFactory(() => MatchesCubit(getMatches: sl()));

  // ==================== Nearby Stadium (home page section) ====================
  sl.registerLazySingleton(() => GetNearbyStadiumUseCase(sl()));

  if (!sl.isRegistered<AppLocationService>()) {
    sl.registerLazySingleton(() => AppLocationService());
  }

  sl.registerFactory(
    () => NearbyStadiumCubit(
      getNearbyStadiumUseCase: sl(),
      locationService: sl(),
    ),
  );
}
