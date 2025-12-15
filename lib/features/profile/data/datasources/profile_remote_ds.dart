import 'package:stadium_eye/features/profile/data/models/userprofile_model.dart';

import '../models/user_data_model.dart';

abstract class ProfileRemoteDs {
  Future<void> createUserProfile(UserProfileModel model);
  Future<UserDataModel> getMyUserProfile();
}
