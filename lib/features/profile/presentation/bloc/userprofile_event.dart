import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';

abstract class UserprofileEvent {}

// class CreateUserProfileEvent extends UserprofileEvent{
//   final UserProfile profile;
//   CreateUserProfileEvent(this.profile);
// }
class GetMyUserProfileEvent extends UserprofileEvent{}