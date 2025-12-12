import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stadium_eye/app.dart';
import 'package:stadium_eye/core/storage/secure_storage.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_bloc.dart';
import 'package:stadium_eye/features/settings/data/repositories/settings_repository_impl.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

import 'features/settings/presentation/bloc/settings_cubit.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  debugPrint(await sl<SecureStorage>().read("token"));

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
        BlocProvider(create: (context) => sl<ReportsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
