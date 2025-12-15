import '../../domain/entities/user_profile_res.dart';

abstract class UserprofileState {}

class UserProfileInitial extends UserprofileState {}

class UserProfileLoading extends UserprofileState {}

class UserProfileLoaded extends UserprofileState {
  final UserProfileResponseEntity profile;

  UserProfileLoaded(this.profile);
}

class UserProfileCreated extends UserprofileState {}

class UserProfileError extends UserprofileState {
  final String message;

  UserProfileError(this.message);
}
