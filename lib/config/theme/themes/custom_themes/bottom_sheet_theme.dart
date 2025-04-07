import 'package:flutter/material.dart';
import '/config/_config.dart';

final bottomSheetThemeDark = const BottomSheetThemeData(
  backgroundColor: DarkThemeColors.surface,
  modalBackgroundColor: DarkThemeColors.surface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  ),
);

final bottomSheetThemeLight = const BottomSheetThemeData(
  backgroundColor: LightThemeColors.surface,
  modalBackgroundColor: LightThemeColors.surface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  ),
);
