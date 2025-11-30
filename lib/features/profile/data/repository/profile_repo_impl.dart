import 'package:stadium_eye/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:stadium_eye/features/profile/domain/entities/user_profile.dart';
import 'package:stadium_eye/features/profile/domain/repository/profile_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final ProfileRemoteDatasource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<UserProfile> getProfile() async {
    return await remote.fetchUserProfile();
  }
}
