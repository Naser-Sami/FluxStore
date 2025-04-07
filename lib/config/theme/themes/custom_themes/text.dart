import 'package:flutter/material.dart';

import '/config/theme/_theme.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TTextStyle.displayLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    displayMedium: TTextStyle.displayMedium().apply(
      color: LightThemeColors.onSurface,
    ),
    displaySmall: TTextStyle.displaySmall().apply(
      color: LightThemeColors.onSurface,
    ),
    headlineLarge: TTextStyle.headlineLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    headlineMedium: TTextStyle.headlineMedium().apply(
      color: LightThemeColors.onSurface,
    ),
    headlineSmall: TTextStyle.headlineSmall().apply(
      color: LightThemeColors.onSurface,
    ),
    titleLarge: TTextStyle.titleLarge().apply(
      color: LightThemeColors.onSurface,
    ),
    titleMedium: TTextStyle.titleMedium().apply(
      color: LightThemeColors.onSurface,
    ),
    titleSmall: TTextStyle.titleSmall().apply(
      color: LightThemeColors.onSurface,
    ),
    bodyLarge: TTextStyle.bodyLarge().apply(color: LightThemeColors.onSurface),
    bodyMedium: TTextStyle.bodyMedium().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    bodySmall: TTextStyle.bodySmall().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelLarge: TTextStyle.labelLarge().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelMedium: TTextStyle.labelMedium().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelSmall: TTextStyle.labelSmall().apply(
      color: LightThemeColors.onSurface.withValues(alpha: 0.60),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TTextStyle.displayLarge().apply(
      color: DarkThemeColors.onSurface,
    ),
    displayMedium: TTextStyle.displayMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
    displaySmall: TTextStyle.displaySmall().apply(
      color: DarkThemeColors.onSurface,
    ),
    headlineLarge: TTextStyle.headlineLarge().apply(
      color: DarkThemeColors.onSurface,
    ),
    headlineMedium: TTextStyle.headlineMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
    headlineSmall: TTextStyle.headlineSmall().apply(
      color: DarkThemeColors.onSurface,
    ),
    titleLarge: TTextStyle.titleLarge().apply(color: DarkThemeColors.onSurface),
    titleMedium: TTextStyle.titleMedium().apply(
      color: DarkThemeColors.onSurface,
    ),
    titleSmall: TTextStyle.titleSmall().apply(color: DarkThemeColors.onSurface),
    bodyLarge: TTextStyle.bodyLarge().apply(color: DarkThemeColors.onSurface),
    bodyMedium: TTextStyle.bodyMedium().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    bodySmall: TTextStyle.bodySmall().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelLarge: TTextStyle.labelLarge().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelMedium: TTextStyle.labelMedium().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
    labelSmall: TTextStyle.labelSmall().apply(
      color: DarkThemeColors.onSurface.withValues(alpha: 0.60),
    ),
  );
}
