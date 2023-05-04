import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_chords/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['assets/translations'];
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale?.languageCode == 'ru') {
          return const Locale('ru', 'RU');
        }
        return const Locale('en', 'US');
      },
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          useMaterial3: true,
          brightness: Brightness.dark),
      home: const ProviderScope(child: MainScreen()),
    );
  }
}
