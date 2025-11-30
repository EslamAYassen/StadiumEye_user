import 'package:stadium_eye/profile_feature/domain/entities/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> getProfile();
}
