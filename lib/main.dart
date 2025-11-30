import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/app.dart';
import 'package:stadium_eye/features/settings/data/repositories/settings_repository_impl.dart';

import 'features/settings/presentation/bloc/settings_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
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
