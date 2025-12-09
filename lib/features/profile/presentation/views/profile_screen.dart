import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:stadium_eye/features/profile/data/datasources/profile_remote_ds_impl.dart';
import 'package:stadium_eye/features/profile/data/repositories/userprofile_repo_impl.dart';
import 'package:stadium_eye/features/profile/domain/usecases/get_userprofile.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_bloc.dart';
import 'package:stadium_eye/features/profile/presentation/bloc/userprofile_event.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserprofileBloc(
        getMyUserProfile: GetUserProfileUseCase(
          UserprofileRepoImpl(
            ProfileRemoteDsImpl(),
          ),
        ),
      ),
      child: const Scaffold(body:  ProfileScreenBody(),),
    );
  }
}