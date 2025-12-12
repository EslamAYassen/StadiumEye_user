import 'user_profile_entity.dart';

class HomeDataEntity {
  final String status;
  final int totalActiveUsers;
  final int totalTeams;
  final int totalTickets;
  final UserProfileEntity user;

  HomeDataEntity({
    required this.status,
    required this.totalActiveUsers,
    required this.totalTeams,
    required this.totalTickets,
    required this.user,
  });
}
