import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.fullName,
    required super.role,
    required super.profilePicture,
    required super.email,
    required super.phone,
    required super.dateOfBirth,
    required super.age,
    required super.gender,
    required super.createdAt,
    required super.loginType,
    super.token,
    super.tokenExpDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String? ?? "First Name",
      lastName: json['lastName'] as String? ?? "Last Name",
      fullName: json['fullName'] as String? ?? "Name",
      role: json['role'] as String,
      profilePicture: json['profilePicture'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      dateOfBirth: DateTime.parse(
        json['dateOfBirth'] as String? ?? DateTime.now().toIso8601String(),
      ),
      age: json['age'] as int? ?? 0,
      gender: json['gender'] as String? ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      loginType: json['loginType'] as String? ?? '',
      token: json['token'] as String? ?? '',
      tokenExpDate: json['tokenExpDate'] != null
          ? DateTime.parse(json['tokenExpDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'role': role,
      'profilePicture': profilePicture,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'age': age,
      'gender': gender,
      'createdAt': createdAt.toIso8601String(),
      'loginType': loginType,
      'token': token,
      'tokenExpDate': tokenExpDate?.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      role: role,
      profilePicture: profilePicture,
      email: email,
      phone: phone,
      dateOfBirth: dateOfBirth,
      age: age,
      gender: gender,
      createdAt: createdAt,
      loginType: loginType,
      token: token,
      tokenExpDate: tokenExpDate,
    );
  }
}
