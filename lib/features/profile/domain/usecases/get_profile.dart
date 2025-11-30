import 'package:stadium_eye/features/profile/domain/entities/user_profile.dart';
import 'package:stadium_eye/features/profile/domain/repository/profile_repo.dart';

class GetProfileUseCase {
  final UserRepository repo;

  GetProfileUseCase(this.repo);

  Future<UserProfile> call() async {
    return await repo.getProfile();
  }
}
