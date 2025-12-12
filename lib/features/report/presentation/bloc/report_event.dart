import 'package:equatable/equatable.dart';
import '../../domain/usecases/create_report_usecase.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyReportsEvent extends ReportsEvent {
  const LoadMyReportsEvent();
}

class LoadCountriesEvent extends ReportsEvent {
  const LoadCountriesEvent();
}

class LoadCitiesEvent extends ReportsEvent {
  const LoadCitiesEvent();
}

class RefreshMyReportsEvent extends ReportsEvent {
  const RefreshMyReportsEvent();
}

class LoadStadiumsEvent extends ReportsEvent {
  const LoadStadiumsEvent();
}

class CreateReportEvent extends ReportsEvent {
  final CreateReportParams params;

  const CreateReportEvent(this.params);

  @override
  List<Object?> get props => [params];
}
