import '../../domain/entites/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.fullName,
    required super.role,
    required super.email,
    required super.phone,
    required super.profilePicture,
    required super.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      role: json['role'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      role: role,
      email: email,
      phone: phone,
      profilePicture: profilePicture,
      createdAt: createdAt,
    );
  }
}
