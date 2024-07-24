import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/pages/splash_screen_page/splash_screen_page.dart';
import 'package:progress_soft_app/core/constants/bloc_providers.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/constants/theme.dart';
import 'package:progress_soft_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      startLocale: const Locale('en'),
      supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
      path: 'assets/lang',
      child: const ProgressSoftApp(),
    ),
  );
}

class ProgressSoftApp extends StatelessWidget {
  const ProgressSoftApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.blocProvidersList,
      child: MaterialApp(
        title: 'ProgressSoft App',
        navigatorKey: navigatorKey,
        theme: AppThemes().lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const SplashScreenPage(),
      ),
    );
  }
}
