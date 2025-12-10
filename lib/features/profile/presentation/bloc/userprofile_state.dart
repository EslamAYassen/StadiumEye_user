import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';

abstract class UserprofileState {}

class UserProfileInitial extends UserprofileState{}

class UserProfileLoading extends UserprofileState{}

class UserProfileLoaded extends UserprofileState {
  final UserProfile profile;

  UserProfileLoaded(this.profile);
}

class UserProfileCreated extends UserprofileState {}

class UserProfileError extends UserprofileState {
  final String message;

  UserProfileError(this.message);
}
