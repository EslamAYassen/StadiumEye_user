import '../../domain/entities/reports_response_entity.dart';
import 'ticket_model.dart';

class ReportsResponseModel extends ReportsResponseEntity {
  ReportsResponseModel({
    required super.status,
    required super.totalResults,
    required super.tickets,
  });

  factory ReportsResponseModel.fromJson(Map<String, dynamic> json) {
    return ReportsResponseModel(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      tickets: (json['tickets'] as List)
          .map((ticket) => TicketModel.fromJson(ticket as Map<String, dynamic>))
          .toList(),
    );
  }
}
