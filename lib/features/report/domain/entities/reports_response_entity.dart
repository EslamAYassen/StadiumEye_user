import 'ticket_entity.dart';

class ReportsResponseEntity {
  final String status;
  final int totalResults;
  final List<TicketEntity> tickets;

  ReportsResponseEntity({
    required this.status,
    required this.totalResults,
    required this.tickets,
  });
}
