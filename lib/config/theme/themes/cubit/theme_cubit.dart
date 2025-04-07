import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '/core/_core.dart'; // Assuming this includes your ThemeStyle enum

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  ThemeStyle get initialValue {
    switch (state) {
      case ThemeMode.light:
        return ThemeStyle.light;
      case ThemeMode.dark:
        return ThemeStyle.dark;
      default:
        return ThemeStyle.system;
    }
  }

  void switchTheme(ThemeStyle t) {
    switch (t) {
      case ThemeStyle.light:
        emit(ThemeMode.light);
        break;
      case ThemeStyle.dark:
        emit(ThemeMode.dark);
        break;
      case ThemeStyle.system:
        emit(ThemeMode.system);
        break;
    }
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    switch (json['theme'] as String?) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'theme': state.name};
  }
}
