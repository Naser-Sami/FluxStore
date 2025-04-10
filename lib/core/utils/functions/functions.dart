// Packages
import 'dart:math';

import 'package:flutter/material.dart';

// Files
import '/core/utils/_utils.dart';

class TFunctions {
  TFunctions._();

  static Future<void> launchUrl(String url) async {
    // if (await canLaunchUrlString(url)) {
    //   await launchUrlString(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  static String getIconSVG(String name) {
    try {
      return '${Constants.pathSystemIcons}$name.svg';
    } catch (e) {
      return '';
    }
  }

  static String getPngImage(String name) {
    try {
      return '${Constants.pathImages}$name.png';
    } catch (e) {
      return '';
    }
  }

  // Get Last (N) Digits in a String
  static String? returnLastNDigits(String? text, int? digits) {
    try {
      if (text == null) {
        return '';
      } else if (digits == null) {
        return '';
      } else {
        return text.substring(text.length - digits);
      }
    } catch (e) {
      return '';
    }
  }

  static bool isNullOrEmpty(String? text) {
    return text == null || text.isEmpty;
  }

  static bool isNotNullOrEmpty(String? text) {
    return text != null && text.isNotEmpty;
  }

  static bool isNullOrZero(int? number) {
    return number == null || number == 0;
  }

  static bool isNotNullOrZero(int? number) {
    return number != null && number != 0;
  }

  static bool isNullOrFalse(bool? value) {
    return value == null || !value;
  }

  static bool isNotNullOrFalse(bool? value) {
    return value != null && value;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isDarkColor(Color color) {
    return color.computeLuminance() < 0.5;
  }

  static bool isLightColor(Color color) {
    return color.computeLuminance() >= 0.5;
  }

  static Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  static Color generateRandomDarkColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(128),
      random.nextInt(128),
      random.nextInt(128),
    );
  }

  static Color generateRandomLightColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(128) + 128,
      random.nextInt(128) + 128,
      random.nextInt(128) + 128,
    );
  }
}
