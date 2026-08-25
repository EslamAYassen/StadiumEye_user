import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/error/failures.dart';
import '../../domain/usecases/create_report_usecase.dart';
import '../../domain/usecases/get_cities_usecase.dart';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../domain/usecases/get_my_reports_usecase.dart';
import '../../domain/usecases/get_stadiums_usecase.dart';
import 'report_event.dart';
import 'report_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetMyReportsUseCase getMyReportsUseCase;
  final GetStadiumsUseCase getStadiumsUseCase;
  final GetCountriesUseCase getCountriesUseCase;
  final CreateReportUseCase createReportUseCase;
  final GetCitiesUseCase getCitiesUseCase;

  ReportsBloc({
    required this.getMyReportsUseCase,
    required this.getStadiumsUseCase,
    required this.createReportUseCase,
    required this.getCitiesUseCase,
    required this.getCountriesUseCase,
  }) : super(const ReportsInitial()) {
    on<LoadMyReportsEvent>(_onLoadMyReports);
    on<RefreshMyReportsEvent>(_onRefreshMyReports);
    on<LoadStadiumsEvent>(_onLoadStadiums);
    // on<LoadCountriesEvent>(_onLoadCountries);
    on<CreateReportEvent>(_onCreateReport);
    on<LoadCitiesEvent>(_onLoadCities);
  }

  Future<void> _onLoadMyReports(
    LoadMyReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    // Only show loading state on first page
    if (event.page == 1) {
      emit(const ReportsLoading());
    }

    final result = await getMyReportsUseCase(
      page: event.page,
      status: event.status,
    );

    result.fold(
      (failure) => emit(ReportsError(failure.message)),
      (reports) => emit(
        ReportsLoaded(
          reports: reports,
          currentPage: event.page,
          currentStatus: event.status,
        ),
      ),
    );
  }

  Future<void> _onRefreshMyReports(
    RefreshMyReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    final result = await getMyReportsUseCase();

    result.fold(
      (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
      (reports) => emit(ReportsLoaded(reports: reports)),
    );
  }

  // Future<void> _onLoadCountries(
  //   LoadCountriesEvent event,
  //   Emitter<ReportsState> emit,
  // ) async {
  //   emit(const ReportsLoading());

  //   final result = await getCountriesUseCase();

  //   result.fold(
  //     (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
  //     (countries) => emit(CountriesLoaded(countries)),
  //   );
  // }

  Future<void> _onLoadCities(
    LoadCitiesEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(const ReportsLoading());

    final result = await getCitiesUseCase();

    result.fold(
      (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
      (cities) => emit(CitiesLoaded(cities)),
    );
  }

  Future<void> _onLoadStadiums(
    LoadStadiumsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(const ReportsLoading());

    final result = await getStadiumsUseCase();

    result.fold(
      (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
      (stadiums) => emit(StadiumsLoaded(stadiums)),
    );
  }

  Future<void> _onCreateReport(
    CreateReportEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(const ReportCreating());

    final result = await createReportUseCase(event.params);

    result.fold(
      (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
      (ticket) => emit(
        ReportCreated(ticket: ticket, message: 'Report created successfully'),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
