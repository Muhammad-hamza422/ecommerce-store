import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode mode;

  const ThemeState({this.mode = ThemeMode.light});

  bool get isDarkMode => mode == ThemeMode.dark;

  ThemeState copyWith({ThemeMode? mode}) {
    return ThemeState(mode: mode ?? this.mode);
  }
}
