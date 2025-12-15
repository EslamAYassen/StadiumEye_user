import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';

import '../../data/models/user_data_model.dart';

abstract class UserRepository {
  Future<void> createUserProfile(UserProfile profile);
  Future<UserDataModel> getMyUserProfile();
}
