import 'package:stadium_eye/features/report/data/models/report_model.dart';

abstract class ReportRemoteDS {
  Future<List<ReportModel>> getHomeData();
}
