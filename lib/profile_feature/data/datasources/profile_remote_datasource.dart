import 'package:stadium_eye/profile_feature/data/model/user_profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<UserProfileModel>fetchUserProfile();
}