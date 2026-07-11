import 'package:stadium_eye/features/profile/data/repositories/userprofile_repo_impl.dart';
import 'package:stadium_eye/features/profile/domain/repositories/userprofile_repo.dart';
import 'package:stadium_eye/features/profile/domain/usecases/get_userprofile.dart';

import '../../injection_container.dart';
import 'data/datasources/profile_remote_ds.dart';
import 'data/datasources/profile_remote_ds_impl.dart';
import 'presentation/bloc/userprofile_bloc.dart';

Future<void> initProfileDependencies() async {
  // ==================== Profile Feature Dependencies ====================

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDs>(() => ProfileRemoteDsImpl());

  // Bloc
  sl.registerFactory(() => UserprofileBloc(getMyUserProfile: sl()));

  sl.registerLazySingleton<UserRepository>(() => UserprofileRepoImpl(sl()));

  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

  // sl.registerLazySingleton(() => use(sl()));
}
