import 'package:flutter/material.dart';
import '/config/theme/_theme.dart';

ThemeData _darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeColors.surface,
  colorScheme: darkColorScheme,
  textTheme: TTextTheme.darkTextTheme,
  primaryTextTheme: TTextTheme.darkTextTheme,
  textButtonTheme: darkTextButtonTheme,
  extensions: darkExtensions,
  dividerTheme: darkDividerTheme,
  dividerColor: DarkThemeColors.onSurface.withValues(alpha: 0.25),
  cardTheme: darkCardTheme,
  cardColor: DarkThemeColors.surface,
  popupMenuTheme: darkPopupMenuTheme,
  elevatedButtonTheme: elevatedButtonThemeDark,
  appBarTheme: appBarThemeDark,
  iconButtonTheme: iconButtonThemeDark,
  bottomSheetTheme: bottomSheetThemeDark,
);

ThemeData get darkTheme => _darkTheme;
