import 'package:stadium_eye/features/profile/data/models/userprofile_model.dart';

abstract class ProfileRemoteDs {
  Future<void> createUserProfile(UserProfileModel model);
  Future<UserProfileModel> getMyUserProfile();
}
