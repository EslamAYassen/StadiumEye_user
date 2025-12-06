class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String profilePicture;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final int age;
  final String gender;
  final DateTime createdAt;
  final String loginType;
  final String? token;
  final DateTime? tokenExpDate;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.profilePicture,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
    required this.createdAt,
    required this.loginType,
    this.token,
    this.tokenExpDate,
  });
}
