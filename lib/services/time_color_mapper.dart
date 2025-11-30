import 'package:flutter/material.dart';
import '../theme/time_mood_theme.dart';

/// A value object holding everything the UI needs
/// to visualize the current time as colors and progress.
@immutable
class TimeVisualState {
  final Color backgroundStart;
  final Color backgroundEnd;
  final Color primary;
  final Color accent;
  final double minuteProgress; // 0..1 across the hour
  final double secondProgress; // 0..1 across the minute

  const TimeVisualState({
    required this.backgroundStart,
    required this.backgroundEnd,
    required this.primary,
    required this.accent,
    required this.minuteProgress,
    required this.secondProgress,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeVisualState &&
          runtimeType == other.runtimeType &&
          backgroundStart == other.backgroundStart &&
          backgroundEnd == other.backgroundEnd &&
          primary == other.primary &&
          accent == other.accent &&
          minuteProgress == other.minuteProgress &&
          secondProgress == other.secondProgress;

  @override
  int get hashCode =>
      backgroundStart.hashCode ^
      backgroundEnd.hashCode ^
      primary.hashCode ^
      accent.hashCode ^
      minuteProgress.hashCode ^
      secondProgress.hashCode;
}

/// Maps [DateTime] + palette into colors and progress values.
class TimeColorMapper {
  const TimeColorMapper();

  TimeVisualState map(DateTime time, TimeMoodPalette palette) {
    final hour = time.hour;
    final minute = time.minute;
    final second = time.second;
    final millisecond = time.millisecond;

    // Total seconds into the hour.
    final totalSeconds = minute * 60 + second + (millisecond / 1000.0);
    
    // Progress across the hour (0.0 to 1.0).
    final minuteProgress = (totalSeconds / 3600.0).clamp(0.0, 1.0);

    // Progress across the minute (0.0 to 1.0).
    final secondProgress = ((second + millisecond / 1000.0) / 60.0).clamp(0.0, 1.0);

    final baseHue = _hourToHue(hour);
    
    // Use minute progress for smoother color transitions instead of discrete minutes
    final minuteFactor = minuteProgress; 
    final config = _paletteConfig(palette);

    // Primary color reacts to hour (hue) and minute (saturation/lightness).
    final hslPrimary = HSLColor.fromAHSL(
      1.0,
      baseHue,
      (config.saturationBase + config.saturationRange * minuteFactor).clamp(0.0, 1.0),
      (config.lightnessBase + config.lightnessRange * minuteFactor).clamp(0.0, 1.0),
    );

    final hslBackgroundEnd = hslPrimary.withLightness(
      (hslPrimary.lightness * 0.8).clamp(0.0, 1.0),
    );

    final hslBackgroundStart = hslBackgroundEnd.withHue(
      (hslBackgroundEnd.hue + 18) % 360,
    );

    final accentHue = (baseHue + 40) % 360;
    final hslAccent = HSLColor.fromAHSL(
      1.0,
      accentHue,
      (config.saturationBase + 0.25).clamp(0.0, 1.0),
      (config.lightnessBase + 0.15).clamp(0.0, 1.0),
    );

    return TimeVisualState(
      backgroundStart: hslBackgroundStart.toColor(),
      backgroundEnd: hslBackgroundEnd.toColor(),
      primary: hslPrimary.toColor(),
      accent: hslAccent.toColor(),
      minuteProgress: minuteProgress,
      secondProgress: secondProgress,
    );
  }

  /// Maps hour ranges to a base Hue.
  double _hourToHue(int hour) {
    if (hour >= 5 && hour < 12) {
      return 50; // Morning: Warm Yellow
    } else if (hour >= 12 && hour < 17) {
      return 200; // Afternoon: Sky Blue
    } else if (hour >= 17 && hour < 21) {
      return 280; // Evening: Purple
    } else {
      return 220; // Night: Deep Blue
    }
  }

  _PaletteConfig _paletteConfig(TimeMoodPalette palette) {
    switch (palette) {
      case TimeMoodPalette.pastel:
        return const _PaletteConfig(
          saturationBase: 0.35,
          saturationRange: 0.15,
          lightnessBase: 0.75,
          lightnessRange: 0.1,
        );
      case TimeMoodPalette.dark:
        return const _PaletteConfig(
          saturationBase: 0.6,
          saturationRange: 0.25,
          lightnessBase: 0.25,
          lightnessRange: 0.15,
        );
      case TimeMoodPalette.vivid:
        return const _PaletteConfig(
          saturationBase: 0.8,
          saturationRange: 0.15,
          lightnessBase: 0.5,
          lightnessRange: 0.2,
        );
    }
  }
}

class _PaletteConfig {
  final double saturationBase;
  final double saturationRange;
  final double lightnessBase;
  final double lightnessRange;

  const _PaletteConfig({
    required this.saturationBase,
    required this.saturationRange,
    required this.lightnessBase,
    required this.lightnessRange,
  });
}
