import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/profile/domain/usecases/get_userprofile.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_event.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_state.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  //final  CreateUserProfile createUserProfile;
  final GetUserProfileUseCase getMyUserProfile;

  UserprofileBloc({  required this.getMyUserProfile})
      : super(UserProfileInitial()) {
    // on<CreateUserProfileEvent>((event, emit) async {
    //   emit(UserProfileLoading());
    //   try {
    //     await createUserProfileEvent(event.profile);
    //     emit(UserProfileCreated());
    //   } catch (e) {
    //     emit(UserProfileError(e.toString()));
    //   }
    // });

    on<GetMyUserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final profile = await getMyUserProfile();
        emit(UserProfileLoaded(profile));}
      catch (e) {
        emit(UserProfileError(e.toString()));
      }
    });
  }

 // Future<void>_onGetMyProfile()


}
