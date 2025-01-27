import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/habit/mood.dart';

class AnimatedMoodIcon extends StatelessWidget {
  final Mood mood;
  final double size;

  const AnimatedMoodIcon({
    super.key,
    required this.mood,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedEmoji(
      mood.moodAnimatedIcon,
      animate: true,
      repeat: true,
      errorWidget: Icon(
        mood.moodIcon,
        color: mood.color,
        size: size,
      ),
    );
  }
}
