import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/profile_feature/domain/usecases/get_profile.dart';
import 'package:stadium_eye/profile_feature/presentation/bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase usecase;
  ProfileCubit(this.usecase) : super(ProfileState(loading: true)) {
    loadProfile();
  }
  Future<void> loadProfile({bool showLoading = false}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          loading: true,
          error: null,
        ),
      );
    }

    try {
      final profile = await usecase();

      emit(
        state.copyWith(
          loading: false,
          profile: profile,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: e.toString(),
        ),
      );
    }
  }

}