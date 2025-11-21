import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';

abstract class ReportEvent {}

class CreateReportEvent extends ReportEvent {
  final ReportEntity report;

  CreateReportEvent(this.report);
}

class GetMyReportsEvent extends ReportEvent {}
