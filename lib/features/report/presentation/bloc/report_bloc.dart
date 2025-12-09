import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_report_usecase.dart';
import '../../domain/usecases/get_my_reports_usecase.dart';
import '../../domain/usecases/get_stadiums_usecase.dart';
import 'report_event.dart';
import 'report_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetMyReportsUseCase getMyReportsUseCase;
  final GetStadiumsUseCase getStadiumsUseCase;
  final CreateReportUseCase createReportUseCase;

  ReportsBloc({
    required this.getMyReportsUseCase,
    required this.getStadiumsUseCase,
    required this.createReportUseCase,
  }) : super(const ReportsInitial()) {
    on<LoadMyReportsEvent>(_onLoadMyReports);
    on<RefreshMyReportsEvent>(_onRefreshMyReports);
    on<LoadStadiumsEvent>(_onLoadStadiums);
    on<CreateReportEvent>(_onCreateReport);
  }

  Future<void> _onLoadMyReports(
    LoadMyReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(const ReportsLoading());

    final result = await getMyReportsUseCase();

    result.fold(
      (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
      (reports) => emit(ReportsLoaded(reports)),
    );
  }

  Future<void> _onRefreshMyReports(
    RefreshMyReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    final result = await getMyReportsUseCase();

    result.fold(
      (failure) => emit(ReportsError(_mapFailureToMessage(failure))),
      (reports) => emit(ReportsLoaded(reports)),
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

  String _mapFailureToMessage(failure) {
    return failure.toString();
  }
}
