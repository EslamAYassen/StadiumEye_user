import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';
import 'package:stadium_eye/features/profile/domain/repositories/userprofile_repo.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserProfile> call() async {
    return await repository.getMyUserProfile();
  }
}
