import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/enums/mood.dart';

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
      mood.lottieAsset,
      animate: true,
      repeat: true,
      errorWidget: FaIcon(
        mood.moodIcon,
        color: mood.color,
        size: size,
      ),
    );
  }
}
