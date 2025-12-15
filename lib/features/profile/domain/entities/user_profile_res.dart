import 'userprofile_entity.dart';

class UserProfileResponseEntity {
  final String status;
  final int totalActiveUsers;
  final int totalTeams;
  final int totalTickets;
  final UserProfile user;

  UserProfileResponseEntity({
    required this.status,
    required this.totalActiveUsers,
    required this.totalTeams,
    required this.totalTickets,
    required this.user,
  });
}
