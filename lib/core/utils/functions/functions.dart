// Packages
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  static String generateStrongPassword({
    int length = 12,
    bool includeLetters = true,
    bool includeNumbers = true,
    bool includeSymbols = true,
  }) {
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_-+=<>?';

    String chars = '';
    if (includeLetters) chars += letters;
    if (includeNumbers) chars += numbers;
    if (includeSymbols) chars += symbols;

    final rand = Random.secure();
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  static Future<File?> pickAndUploadProfileImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick image from gallery or camera
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery, // or ImageSource.camera
        imageQuality: 85, // compress
      );

      if (image == null) return null;

      final File file = File(image.path);

      return file;
    } catch (e) {
      debugPrint('Image upload error: $e');
      return null;
    }
  }

  static Color hexToColor(String hex) {
    // Ensure the string is 6 characters and uppercase
    hex = hex.toUpperCase().replaceAll('#', '');

    // Add full opacity (FF) if not provided
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    // Parse and return
    return Color(int.parse(hex, radix: 16));
  }
}
