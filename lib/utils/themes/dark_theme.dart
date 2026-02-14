import 'package:flutter/material.dart';

import 'theme_constants.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black87,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF1C486F),
    inversePrimary: accentGreen,
    secondary: const Color.fromARGB(255, 44, 44, 44),
    onSecondary: Colors.grey.shade800,
    surface: Colors.grey.shade900,
    onPrimary: Colors.white,
    onSurface: Colors.white,
    tertiary: Colors.grey.shade600,
    onTertiary: Colors.grey.shade700,
    tertiaryContainer: Colors.grey.shade900,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1C486F),
    foregroundColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardTheme: CardThemeData(color: Colors.grey.shade800),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF1C486F),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
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
    hintStyle: TextStyle(color: Colors.grey.shade400),
    labelStyle: TextStyle(color: Colors.grey.shade400),
    floatingLabelStyle: const TextStyle(color: Colors.white),
    errorMaxLines: 2,
  ),
);
