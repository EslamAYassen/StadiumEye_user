import '../../domain/entities/report_entity.dart';
import '../../domain/repositories/report_repo.dart';
import '../datasources/report_remote_ds.dart';
import '../models/report_model.dart';

class ReportRepoImpl implements ReportRepo {
  final ReportRemoteDS remoteDS;

  ReportRepoImpl(this.remoteDS);

  @override
  Future<void> createReport(ReportEntity report) async {
    final model = ReportModel(
      stadiumId: report.stadiumId,
      ticketType: report.ticketType,
      title: report.title,
      description: report.description,
      priority: report.priority,
      visibility: report.visibility,
      location: report.location,
      manualEntry: report.manualEntry,
    );

    return await remoteDS.createReport(model);
  }

  @override
  Future<List<ReportEntity>> getMyReports() async {
    return await remoteDS.getMyReports();
  }
}
