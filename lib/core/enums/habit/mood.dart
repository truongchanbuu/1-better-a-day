import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../helpers/enum_helper.dart';

enum Mood {
  great,
  good,
  neutral,
  bad,
  terrible;

  static Mood fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? neutral;

  Color get color {
    switch (this) {
      case Mood.great:
        return Colors.green;
      case Mood.good:
        return Colors.amber;
      case Mood.neutral:
        return Colors.grey;
      case Mood.bad:
        return Colors.orange;
      case Mood.terrible:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  IconData get moodIcon {
    switch (this) {
      case Mood.great:
        return FontAwesomeIcons.faceSmileBeam;
      case Mood.good:
        return FontAwesomeIcons.faceSmile;
      case Mood.neutral:
        return FontAwesomeIcons.faceMeh;
      case Mood.bad:
        return FontAwesomeIcons.faceFrown;
      case Mood.terrible:
        return FontAwesomeIcons.faceSadTear;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  AnimatedEmojiData get lottieAsset {
    switch (this) {
      case Mood.great:
        return AnimatedEmojis.partyingFace;
      case Mood.good:
        return AnimatedEmojis.smileWithBigEyes;
      case Mood.neutral:
        return AnimatedEmojis.neutralFace;
      case Mood.bad:
        return AnimatedEmojis.sad;
      case Mood.terrible:
        return AnimatedEmojis.angry;
      default:
        return AnimatedEmojis.slightlyHappy;
    }
  }
}
