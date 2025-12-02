import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stadium_eye/constants/app_routes.dart';
import 'package:stadium_eye/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:stadium_eye/theme/app_theme.dart';
import 'package:stadium_eye/utils/language.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: AppRoutes.home,
          supportedLocales: AppLanguage.values
              .map((lang) => Locale(lang.code))
              .toList(),
          localizationsDelegates: const [
            // AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: state is SettingsLoaded && state.isDarkMode == true
              ? AppTheme.mainTheme
              : null,
          locale: Locale(state is SettingsLoaded ? state.locale.code : 'en'),
          title: 'Stadium Eye',
        );
      },
    );
  }
}
