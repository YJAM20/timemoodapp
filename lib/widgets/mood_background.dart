import 'package:flutter/material.dart';
import '../services/time_color_mapper.dart';

/// Full-screen background reacting to time colors.
class MoodBackground extends StatelessWidget {
  final TimeVisualState visual;

  const MoodBackground({
    super.key,
    required this.visual,
  });

  @override
  Widget build(BuildContext context) {
    // Optimization: Removed AnimatedContainer.
    // Since the parent updates the state every frame (60fps), 
    // we don't need implicit animations here. The smooth transition
    // is handled by the continuous color updates from the mapper.
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            visual.backgroundStart,
            visual.backgroundEnd,
          ],
        ),
      ),
    );
  }
}
