import '../../domain/entites/home_data_entity.dart';
import 'user_profile_model.dart';

class HomeDataModel extends HomeDataEntity {
  HomeDataModel({
    required super.status,
    required super.totalActiveUsers,
    required super.totalTeams,
    required super.totalTickets,
    required super.user,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      status: json['status'] as String,
      totalActiveUsers: json['totalActiveUsers'] as int,
      totalTeams: json['totalTeams'] as int,
      totalTickets: json['totalTickets'] as int,
      user: UserProfileModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalActiveUsers': totalActiveUsers,
      'totalTeams': totalTeams,
      'totalTickets': totalTickets,
      'user': (user as UserProfileModel).toJson(),
    };
  }

  HomeDataEntity toEntity() {
    return HomeDataEntity(
      status: status,
      totalActiveUsers: totalActiveUsers,
      totalTeams: totalTeams,
      totalTickets: totalTickets,
      user: user,
    );
  }
}
