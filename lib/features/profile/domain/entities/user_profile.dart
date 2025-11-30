class UserProfile {
  final String name;
  final String email;
  final String? avatarUrl;
  final String phone;
  final String location;
  final int reports;
  final int approved;
  final int pending;


  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.reports,
    required this.approved,
    required this.pending,
    this.avatarUrl,         //optional
  });
}
