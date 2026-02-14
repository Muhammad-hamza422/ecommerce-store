import 'package:flutter/material.dart';

import 'theme_constants.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF1C486F),
    inversePrimary: accentGreen,
    secondary: Colors.white,
    onSecondary: Colors.black87,
    surface: Colors.grey.shade200,
    onPrimary: Colors.white,
    onSurface: Colors.black,
    tertiary: Colors.grey.shade600,
    onTertiary: Colors.grey.shade200,
    tertiaryContainer: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1C486F),
    foregroundColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
  ),
  cardTheme: const CardThemeData(color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF1C486F),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF1C486F), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300, width: 2),
    ),
    errorStyle: TextStyle(color: Colors.red.shade300),
    hintStyle: TextStyle(color: Colors.grey.shade600),
    labelStyle: TextStyle(color: Colors.grey.shade600),
    floatingLabelStyle: const TextStyle(color: Colors.black),
    errorMaxLines: 2,
  ),
);
