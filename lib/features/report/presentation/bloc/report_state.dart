import 'package:equatable/equatable.dart';
import '../../domain/entities/cities_response_entity.dart';
import '../../domain/entities/reports_response_entity.dart';
import '../../domain/entities/stadiums_response_entity.dart';
import '../../domain/entities/ticket_entity.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {
  const ReportsInitial();
}

class ReportsLoading extends ReportsState {
  const ReportsLoading();
}

class ReportsLoaded extends ReportsState {
  final ReportsResponseEntity reports;

  const ReportsLoaded(this.reports);

  @override
  List<Object?> get props => [reports];
}

class StadiumsLoaded extends ReportsState {
  final StadiumsResponseEntity stadiums;

  const StadiumsLoaded(this.stadiums);

  @override
  List<Object?> get props => [stadiums];
}

class CitiesLoaded extends ReportsState {
  final CitiesResponseEntity cities;

  const CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class ReportCreating extends ReportsState {
  const ReportCreating();
}

class ReportCreated extends ReportsState {
  final TicketEntity ticket;
  final String message;

  const ReportCreated({required this.ticket, required this.message});

  @override
  List<Object?> get props => [ticket, message];
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object?> get props => [message];
}
