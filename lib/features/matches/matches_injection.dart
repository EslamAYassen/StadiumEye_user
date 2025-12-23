// lib/features/matches/matches_injection.dart
import '../../injection_container.dart';

import 'data/datasources/matches_remote_ds.dart';
import 'data/repositories/matches_repository.dart';
import 'presentation/cubit/matches_cubit.dart';

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
}
