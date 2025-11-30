import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'services/time_color_mapper.dart';
import 'services/mood_message_service.dart';
import 'theme/time_mood_theme.dart';
import 'widgets/time_mood_visualizer.dart';
import 'widgets/mood_background.dart';
import 'widgets/mood_message_overlay.dart';

void main() {
  runApp(const TimeMoodApp());
}

class TimeMoodApp extends StatelessWidget {
  const TimeMoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Mood Visualizer',
      debugShowCheckedModeBanner: false,
      theme: TimeMoodTheme.darkTheme,
      home: const TimeMoodHomePage(),
    );
  }
}

class TimeMoodHomePage extends StatefulWidget {
  const TimeMoodHomePage({super.key});

  @override
  State<TimeMoodHomePage> createState() => _TimeMoodHomePageState();
}

class _TimeMoodHomePageState extends State<TimeMoodHomePage> with SingleTickerProviderStateMixin {
  final TimeColorMapper _mapper = const TimeColorMapper();
  
  late final Ticker _ticker;
  DateTime _now = DateTime.now();

  int _paletteIndex = 0;
  VisualizationStyle _style = VisualizationStyle.circular;
  bool _showMessage = false;

  List<TimeMoodPalette> get _palettes => TimeMoodPalette.values;

  @override
  void initState() {
    super.initState();
    // Using Ticker for smooth 60fps animations to prevent UI jank
    _ticker = createTicker((_) {
      setState(() {
        _now = DateTime.now();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _paletteIndex = (_paletteIndex + 1) % _palettes.length;
    });
  }

  void _handleLongPress() {
    setState(() {
      _style = _style == VisualizationStyle.circular
          ? VisualizationStyle.linear
          : VisualizationStyle.circular;
    });
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    // Negative delta means user is swiping up.
    if (details.primaryDelta != null && details.primaryDelta! < -10) {
      if (!_showMessage) {
        setState(() {
          _showMessage = true;
        });
      }
    }
  }

  void _dismissMessage() {
    setState(() {
      _showMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _palettes[_paletteIndex];
    final visual = _mapper.map(_now, palette);

    return Scaffold(
      // Optimize repaints by repainting only when necessary
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        onLongPress: _handleLongPress,
        onVerticalDragUpdate: _handleVerticalDragUpdate,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background gradient reacting to time.
            RepaintBoundary(
              child: MoodBackground(visual: visual),
            ),
            // Main visual representation of time.
            Center(
              child: RepaintBoundary(
                child: TimeMoodVisualizer(
                  visual: visual,
                  style: _style,
                ),
              ),
            ),
            // Hint / controls text.
            const _ControlsHint(),
            // Time-of-day message overlay.
            MoodMessageOverlay(
              visible: _showMessage,
              message: MoodMessageService.getMessageForTime(_now),
              onDismiss: _dismissMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlsHint extends StatelessWidget {
  const _ControlsHint();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24 + MediaQuery.paddingOf(context).bottom,
      child: IgnorePointer(
        child: Text(
          'Tap to change palette  •  Long press to switch style  •  Swipe up for a time mood',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
