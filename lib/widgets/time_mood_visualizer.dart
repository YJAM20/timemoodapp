import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../services/time_color_mapper.dart';

/// Two basic visualization styles the user can switch between.
enum VisualizationStyle {
  circular,
  linear,
}

/// The main visual widget that draws shapes and uses the
/// [TimeVisualState] values to represent the current time.
class TimeMoodVisualizer extends StatelessWidget {
  final TimeVisualState visual;
  final VisualizationStyle style;

  const TimeMoodVisualizer({
    super.key,
    required this.visual,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case VisualizationStyle.circular:
        return _CircularTimeMood(visual: visual);
      case VisualizationStyle.linear:
        return _LinearTimeMood(visual: visual);
    }
  }
}

class _CircularTimeMood extends StatelessWidget {
  final TimeVisualState visual;

  const _CircularTimeMood({required this.visual});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final diameter = math.min(size.width, size.height) * 0.55;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Minute ring.
          // Optimization: Removed TweenAnimationBuilder.
          // The state is updated at 60fps by the parent Ticker, so we render directly.
          SizedBox(
            width: diameter,
            height: diameter,
            child: CircularProgressIndicator(
              value: visual.minuteProgress,
              strokeWidth: diameter * 0.08,
              backgroundColor: visual.primary.withOpacity(0.18),
              valueColor: AlwaysStoppedAnimation<Color>(
                visual.primary,
              ),
            ),
          ),
          // Seconds-driven orbiting dot.
          SizedBox(
            width: diameter * 0.8,
            height: diameter * 0.8,
            child: Transform.rotate(
              angle: visual.secondProgress * 2 * math.pi,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: diameter * 0.11,
                  height: diameter * 0.11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: visual.accent,
                    boxShadow: [
                      BoxShadow(
                        color: visual.accent.withOpacity(0.6),
                        blurRadius: 18,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Soft inner circle for breathing space.
          Container(
            width: diameter * 0.4,
            height: diameter * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinearTimeMood extends StatelessWidget {
  final TimeVisualState visual;

  const _LinearTimeMood({required this.visual});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = math.min(size.width * 0.8, 420.0);
    final barHeight = 18.0;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minute progress bar.
          // Optimization: Render directly from state.
          Container(
            height: barHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(barHeight / 2),
              color: visual.primary.withOpacity(0.2),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: visual.minuteProgress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(barHeight / 2),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        visual.primary,
                        visual.accent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Seconds marker sliding along a faint track.
          SizedBox(
            height: barHeight * 2.0,
            width: width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 2,
                    width: width,
                    color: Colors.white.withOpacity(0.18),
                  ),
                ),
                Align(
                  alignment: Alignment(
                    -1.0 + 2.0 * visual.secondProgress,
                    0,
                  ),
                  child: Container(
                    width: barHeight * 1.4,
                    height: barHeight * 1.4,
                    decoration: BoxDecoration(
                      color: visual.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: visual.accent.withOpacity(0.6),
                          blurRadius: 14,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
