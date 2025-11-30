// Basic smoke test for TimeMoodApp
import 'package:flutter_test/flutter_test.dart';
import 'package:timemoodapp/main.dart';

void main() {
  testWidgets('App loads and displays visualizer smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TimeMoodApp());

    // Verify that the main visualizer is present.
    // We look for the text that appears at the bottom to confirm the screen loaded.
    expect(find.textContaining('Tap to change palette'), findsOneWidget);
  });
}
