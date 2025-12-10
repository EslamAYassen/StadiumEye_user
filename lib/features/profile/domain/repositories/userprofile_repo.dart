import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';

abstract class UserRepository {
  Future<void> createUserProfile(UserProfile profile);
  Future<UserProfile> getMyUserProfile();
}
