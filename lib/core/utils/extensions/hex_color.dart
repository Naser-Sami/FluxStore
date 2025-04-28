// import 'dart:ui' show Color;

// extension HexColorExtension on String {
//   Color toColor() {
//     String hex = replaceAll('#', '').toUpperCase();
//     if (hex.length == 6) hex = 'FF$hex';
//     return Color(int.parse(hex, radix: 16));
//   }
// }

// extension ColorExtension on Color {
//   bool isDark() {
//     return computeLuminance() < 0.5;
//   }

//   bool isLight() {
//     return computeLuminance() >= 0.5;
//   }

//   String toHex() {
//     return '#'
//             '${alpha.toRadixString(16).padLeft(2, '0')}'
//             '${red.toRadixString(16).padLeft(2, '0')}'
//             '${green.toRadixString(16).padLeft(2, '0')}'
//             '${blue.toRadixString(16).padLeft(2, '0')}'
//         .toUpperCase();
//   }
// }

import 'package:flutter/material.dart';

extension HexColorExtension on String {
  static const Map<String, String> colorNameToHex = {
    'aliceblue': 'F0F8FF',
    'antiquewhite': 'FAEBD7',
    'aqua': '00FFFF',
    'aquamarine': '7FFFD4',
    'azure': 'F0FFFF',
    'beige': 'F5F5DC',
    'bisque': 'FFE4C4',
    'black': '000000',
    'blanchedalmond': 'FFEBCD',
    'blue': '0000FF',
    'blueviolet': '8A2BE2',
    'brown': 'A52A2A',
    // Add all other CSS color names here
  };

  static final colorHexToName = colorNameToHex.map(
    (key, value) => MapEntry(value, key),
  );

  Color toColor() {
    String hex = _normalizeHex(replaceAll('#', ''));
    return Color(int.parse(hex, radix: 16));
  }

  String toHex() {
    if (colorNameToHex.containsKey(toLowerCase())) {
      return '#FF${colorNameToHex[toLowerCase()]}';
    }

    String hex = _normalizeHex(replaceAll('#', ''));
    return '#$hex';
  }

  String? toColorName() {
    try {
      final color = toColor();
      String rgbHex =
          color.value
              .toRadixString(16)
              .padLeft(8, '0')
              .substring(2)
              .toUpperCase();
      return colorHexToName[rgbHex];
    } catch (e) {
      return null;
    }
  }

  bool get isValidColor {
    if (colorNameToHex.containsKey(toLowerCase())) return true;
    final hex = replaceAll('#', '');
    return RegExp(
      r'^([0-9A-Fa-f]{3}|[0-9A-Fa-f]{4}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$',
    ).hasMatch(hex);
  }

  String _normalizeHex(String hex) {
    hex = hex.toUpperCase();
    if (hex.length == 3 || hex.length == 4) {
      hex = hex.split('').map((c) => c + c).join();
    }
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length != 8) throw ArgumentError('Invalid hex color: $this');
    return hex;
  }

  // Additional utility
  Map<String, int> toRgb() {
    final color = toColor();
    return {'r': color.red, 'g': color.green, 'b': color.blue};
  }

  // Additional utility
  String withAlpha(int alpha) {
    final hex = replaceAll('#', '');
    final normalized = _normalizeHex(hex);
    final newHex = normalized.replaceRange(
      0,
      2,
      alpha.toRadixString(16).padLeft(2, '0'),
    );
    return '#$newHex';
  }
}
