import 'package:flutter/material.dart';
import '/config/_config.dart' show DarkThemeColors;

final ColorScheme darkColorScheme = const ColorScheme.dark(
  brightness: Brightness.dark,

  primary: DarkThemeColors.primary,
  onPrimary: DarkThemeColors.onPrimary,
  primaryContainer: DarkThemeColors.primaryContainer,
  onPrimaryContainer: DarkThemeColors.onPrimaryContainer,

  secondary: DarkThemeColors.secondary,
  onSecondary: DarkThemeColors.onSecondary,
  secondaryContainer: DarkThemeColors.onSecondaryContainer,
  onSecondaryContainer: DarkThemeColors.onSurface,

  tertiary: DarkThemeColors.tertiary,
  onTertiary: DarkThemeColors.onTertiary,
  tertiaryContainer: DarkThemeColors.tertiaryContainer,
  onTertiaryContainer: DarkThemeColors.onTertiaryContainer,

  error: DarkThemeColors.error,
  onError: DarkThemeColors.onError,
  errorContainer: DarkThemeColors.errorContainer,
  onErrorContainer: DarkThemeColors.onErrorContainer,

  surfaceDim: DarkThemeColors.surfaceDim,
  surface: DarkThemeColors.surface,
  surfaceBright: DarkThemeColors.surfaceBright,

  inverseSurface: DarkThemeColors.inverseSurface,
  onInverseSurface: DarkThemeColors.inverseOnSurface,
  inversePrimary: DarkThemeColors.inversePrimary,

  surfaceContainerLowest: DarkThemeColors.surfaceContainerLowest,
  surfaceContainerLow: DarkThemeColors.surfaceContainerLow,
  surfaceContainer: DarkThemeColors.surfaceContainer,
  surfaceContainerHigh: DarkThemeColors.surfaceContainerHight,
  surfaceContainerHighest: DarkThemeColors.surfaceContainerHightest,

  onSurface: DarkThemeColors.onSurface,
  onSurfaceVariant: DarkThemeColors.onSurfaceVariant,

  outline: DarkThemeColors.outline,
  outlineVariant: DarkThemeColors.outlineVariant,

  shadow: DarkThemeColors.shadow,
  scrim: DarkThemeColors.scrim,
);
