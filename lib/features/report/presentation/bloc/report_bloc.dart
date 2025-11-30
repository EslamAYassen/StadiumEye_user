import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/report/domain/usecases/create_report.dart';
import 'package:stadium_eye/features/report/domain/usecases/get_my_reports.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final CreateReport createReport;
  final GetMyReports getMyReports;

  ReportBloc({required this.createReport, required this.getMyReports})
    : super(ReportInitial()) {
    on<CreateReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        await createReport(event.report);
        emit(ReportCreated());
      } catch (e) {
        emit(ReportError(e.toString()));
      }
    });

    on<GetMyReportsEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        final list = await getMyReports();
        emit(ReportLoaded(list));
      } catch (e) {
        emit(ReportError(e.toString()));
      }
    });
  }
}
