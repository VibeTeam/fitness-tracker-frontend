import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      background: Color(0xffF5F5F5),
      surface: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffF5F5F5),
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    useMaterial3: true,
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryBlue,
      background: Color(0xff121212),
      surface: Color(0xff1E1E1E),
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xff121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff121212),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    useMaterial3: true,
  );
}