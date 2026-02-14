import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void toggleTheme() {
    emit(state.copyWith(mode: state.isDarkMode ? ThemeMode.light : ThemeMode.dark));
  }

  void setTheme(ThemeMode mode) {
    emit(state.copyWith(mode: mode));
  }
}
