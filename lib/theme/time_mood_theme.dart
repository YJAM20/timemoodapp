import 'package:flutter/material.dart';

/// High-level palette, used to slightly change how the mapper
/// turns time into colors.
enum TimeMoodPalette {
  pastel,
  dark,
  vivid,
}

extension TimeMoodPaletteLabel on TimeMoodPalette {
  String get label {
    switch (this) {
      case TimeMoodPalette.pastel:
        return 'Pastel';
      case TimeMoodPalette.dark:
        return 'Dark';
      case TimeMoodPalette.vivid:
        return 'Vivid';
    }
  }
}

class TimeMoodTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Roboto',
      useMaterial3: true,
    );
  }
}

/// Optional shared text style helpers if you want to reuse them later.
class TimeMoodTextStyles {
  static const TextStyle overlayMessage = TextStyle(
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}
