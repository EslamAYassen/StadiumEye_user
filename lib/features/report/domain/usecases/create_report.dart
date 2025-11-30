import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';
import 'package:stadium_eye/features/report/domain/repositories/report_repo.dart';

class CreateReport {
  final ReportRepo repo;

  CreateReport(this.repo);

  Future<void> call(ReportEntity report) async {
    return await repo.createReport(report);
  }
}
