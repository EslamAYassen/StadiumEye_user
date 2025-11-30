import 'package:stadium_eye/features/report/domain/entities/report_entity.dart';
import 'package:stadium_eye/features/report/domain/repositories/report_repo.dart';

class GetMyReports {
  final ReportRepo repo;

  GetMyReports(this.repo);

  Future<List<ReportEntity>> call() async {
    return await repo.getMyReports();
  }
}
