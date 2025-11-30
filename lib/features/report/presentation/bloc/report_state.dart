import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportEntity> reports;

  ReportLoaded(this.reports);
}

class ReportCreated extends ReportState {}

class ReportError extends ReportState {
  final String message;

  ReportError(this.message);
}
