import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';

abstract class ReportRepo {
  Future<void> createReport(ReportEntity report);
  Future<List<ReportEntity>> getMyReports();
}
