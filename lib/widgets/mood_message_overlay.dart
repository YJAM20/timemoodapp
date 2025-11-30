import 'package:flutter/material.dart';
import '../theme/time_mood_theme.dart';

/// Simple overlay that slides/fades in a short message about
/// the time of day. Triggered via swipe up.
class MoodMessageOverlay extends StatelessWidget {
  final bool visible;
  final String message;
  final VoidCallback onDismiss;

  const MoodMessageOverlay({
    super.key,
    required this.visible,
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    // Optimization: Use paddingOf to subscribe only to padding changes, not all MQ changes.
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 24.0;

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: bottomPadding,
            ),
            child: GestureDetector(
              onTap: onDismiss,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.45),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TimeMoodTextStyles.overlayMessage,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
