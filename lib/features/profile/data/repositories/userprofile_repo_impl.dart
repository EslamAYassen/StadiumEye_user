import 'package:stadium_eye/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:stadium_eye/features/profile/data/models/userprofile_model.dart';
import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';
import 'package:stadium_eye/features/profile/domain/repositories/userprofile_repo.dart';

class UserprofileRepoImpl implements UserRepository {
  final ProfileRemoteDs remoteDS;
  UserprofileRepoImpl(this.remoteDS);

  @override
  Future<void> createUserProfile(UserProfile profile) async {
    final model = UserProfileModel(
        id: profile.id,
        firstName: profile.firstName,
        lastName: profile.lastName,
        fullName: profile.fullName,
        role: profile.role,
        email: profile.email,
        phone: profile.phone,
        createdAt: profile.createdAt
    );
    return await remoteDS.createUserProfile(model);
  }

  @override
  Future<UserProfile> getMyUserProfile() async {
    return await remoteDS.getMyUserProfile();
  }
}