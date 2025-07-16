import 'package:fitness_tracker_frontend/screens/exercises_page.dart';
import 'package:fitness_tracker_frontend/screens/sign_in_page.dart';
import 'package:fitness_tracker_frontend/screens/sign_up_page.dart';
import 'package:fitness_tracker_frontend/screens/splash_screen.dart';
import '/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.light;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

 void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  ThemeMode get themeMode => _themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const SignInPage(),
        '/register': (context) => const SignUpPage(),
        '/main': (context) => const MainScreen(),
        '/exercises_group': (context) => const ExercisesGroupPage(),
      },
    );
  }
}
