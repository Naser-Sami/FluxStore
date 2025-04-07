import 'package:flutter/material.dart';
import '/config/theme/_theme.dart';

ThemeData _lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: TTextTheme.lightTextTheme,
  primaryTextTheme: TTextTheme.lightTextTheme,
  textButtonTheme: lightTextButtonTheme,
  scaffoldBackgroundColor: LightThemeColors.surface,
  extensions: lightExtensions,
  dividerTheme: lightDividerTheme,
  dividerColor: LightThemeColors.onSurface.withValues(alpha: 0.25),
  cardTheme: lightCardTheme,
  cardColor: LightThemeColors.surface,
  popupMenuTheme: lightPopupMenuTheme,
  elevatedButtonTheme: elevatedButtonThemeLight,
  appBarTheme: appBarThemeLight,
  iconButtonTheme: iconButtonThemeLight,
  bottomSheetTheme: bottomSheetThemeLight,
);

ThemeData get lightTheme => _lightTheme;
