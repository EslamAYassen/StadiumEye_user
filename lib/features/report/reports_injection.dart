import 'package:get_it/get_it.dart';
import 'data/datasources/reports_remote_datasource.dart';
import 'data/repositories/reports_repository_impl.dart';
import 'domain/repositories/reports_repository.dart';
import 'domain/usecases/create_report_usecase.dart';
import 'domain/usecases/get_cities_usecase.dart';
import 'domain/usecases/get_my_reports_usecase.dart';
import 'domain/usecases/get_stadiums_usecase.dart';
import 'presentation/bloc/report_bloc.dart';

final sl = GetIt.instance;

Future<void> initReportsDependencies() async {
  // ==================== Bloc ====================
  sl.registerFactory(
    () => ReportsBloc(
      getMyReportsUseCase: sl(),
      getStadiumsUseCase: sl(),
      createReportUseCase: sl(),
      getCitiesUseCase: sl(),
    ),
  );

  // ==================== Use Cases ====================
  sl.registerLazySingleton(() => GetMyReportsUseCase(sl()));
  sl.registerLazySingleton(() => GetStadiumsUseCase(sl()));
  sl.registerLazySingleton(() => CreateReportUseCase(sl()));
  sl.registerLazySingleton(() => GetCitiesUseCase(sl()));

  // ==================== Repository ====================
  sl.registerLazySingleton<ReportsRepository>(
    () => ReportsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // ==================== Data Sources ====================
  sl.registerLazySingleton<ReportsRemoteDataSource>(
    () => ReportsRemoteDataSourceImpl(sl()),
  );
}
