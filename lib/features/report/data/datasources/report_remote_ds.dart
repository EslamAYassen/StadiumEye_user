import 'package:stadium_eye/features/report/data/models/report_model.dart';

abstract class ReportRemoteDS {
  Future<void> createReport(ReportModel model);
  Future<List<ReportModel>> getMyReports();
}
