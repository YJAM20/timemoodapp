class MoodMessageService {
  static String getMessageForTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;

    final List<String> messages;

    if (hour >= 5 && hour < 12) {
      messages = const [
        'Soft morning energy.',
        'A quiet start to the day.',
        'Fresh light, fresh mood.',
      ];
    } else if (hour >= 12 && hour < 17) {
      messages = const [
        'Steady afternoon flow.',
        'Time stretches, but gently.',
        'Bright hours in motion.',
      ];
    } else if (hour >= 17 && hour < 22) {
      messages = const [
        'Colors soften into evening.',
        'The day slowly exhales.',
        'Calm light after the rush.',
      ];
    } else {
      messages = const [
        'Night wraps around the hours.',
        'Quiet time between ticks.',
        'Shadows are gentle companions.',
      ];
    }

    return messages[minute % messages.length];
  }
}
