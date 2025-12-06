import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stadium_eye/app.dart';
import 'package:stadium_eye/features/settings/data/repositories/settings_repository_impl.dart';

import 'core/networking/network_info.dart';
import 'features/auth/auth_injection.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/settings/presentation/bloc/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAuthDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<AuthBloc>()..add(const CheckAuthStatusEvent()),
        ),
        BlocProvider(
          create: (context) =>
              SettingsCubit(settingsRepository: SettingsRepositoryImpl())
                ..loadSettings(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
