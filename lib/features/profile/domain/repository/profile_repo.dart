import 'package:stadium_eye/features/profile/domain/entities/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> getProfile();
}
