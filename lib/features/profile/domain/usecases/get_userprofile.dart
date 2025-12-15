import 'package:stadium_eye/features/profile/domain/entities/user_profile_res.dart';
import 'package:stadium_eye/features/profile/domain/repositories/userprofile_repo.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserProfileResponseEntity> call() async {
    return await repository.getMyUserProfile();
  }
}
