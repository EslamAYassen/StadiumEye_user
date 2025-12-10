import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.fullName,
    required super.role,
    required super.email,
    required super.phone,
    super.profilePicture,
    required super.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return UserProfileModel(
      id: user['_id'],
      firstName: user['firstName'],
      lastName: user['lastName'],
      fullName: user['fullName'],
      role: user['role'],
      email: user['email'],
      phone: user['phone'],
      profilePicture: user['profilePicture'],
      createdAt: DateTime.parse(user['createdAt']),
    );
  }
}
