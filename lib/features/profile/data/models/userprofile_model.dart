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
    // final user = json['user'];

    return UserProfileModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: json['profilePicture'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'fullName': fullName,
    'role': role,
    'email': email,
    'phone': phone,
    'profilePicture': profilePicture,
    'createdAt': createdAt.toIso8601String(),
  };
}
