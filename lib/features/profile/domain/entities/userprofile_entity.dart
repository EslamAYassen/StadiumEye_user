class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String email;
  final String phone;
  final String? profilePicture;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.email,
    required this.phone,
    this.profilePicture,
    required this.createdAt,
  });
}
