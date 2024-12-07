import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/enum_helper.dart';

enum Mood {
  great,
  good,
  neutral,
  bad,
  terrible;

  static Mood fromString(String str) =>
      EnumHelper.fromString(values, str) ?? neutral;

  static IconData moodIcon(Mood mood) {
    switch (mood) {
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
}
