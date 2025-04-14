import 'package:flutter/material.dart';

import '/config/_config.dart';

CardThemeData? lightCardTheme = CardThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  color: LightThemeColors.surface,
  surfaceTintColor: LightThemeColors.onSurface,
);

CardThemeData? darkCardTheme = CardThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  color: DarkThemeColors.surface,
);
