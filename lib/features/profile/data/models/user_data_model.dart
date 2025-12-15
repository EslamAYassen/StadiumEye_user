import 'package:stadium_eye/features/profile/domain/entities/user_profile_res.dart';

import 'userprofile_model.dart';

class UserDataModel extends UserProfileResponseEntity {
  UserDataModel({
    required super.status,
    required super.totalActiveUsers,
    required super.totalTeams,
    required super.totalTickets,
    required super.user,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
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

  UserProfileResponseEntity toEntity() {
    return UserProfileResponseEntity(
      status: status,
      totalActiveUsers: totalActiveUsers,
      totalTeams: totalTeams,
      totalTickets: totalTickets,
      user: user,
    );
  }
}
