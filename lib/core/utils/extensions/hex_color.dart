import 'dart:ui' show Color;

extension HexColorExtension on String {
  Color toColor() {
    String hex = replaceAll('#', '').toUpperCase();
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
