import 'package:stadium_eye/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.location,
    required super.reports,
    required super.approved,
    required super.pending,
    super.avatarUrl, //optional
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      reports: json['reports'],
      approved: json['approved'],
      pending: json['pending'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
