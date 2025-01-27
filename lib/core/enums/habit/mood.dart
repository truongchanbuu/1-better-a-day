import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum Mood {
  @JsonValue('great')
  great,
  @JsonValue('good')
  good,
  @JsonValue('neutral')
  neutral,
  @JsonValue('bad')
  bad,
  @JsonValue('terrible')
  terrible;

  static Mood fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? neutral;

  static Mood fromMultiString(String? str) {
    final moodMap = {
      S.current.mood_great: great,
      S.current.mood_good: good,
      S.current.mood_neutral: neutral,
      S.current.mood_bad: bad,
      S.current.mood_terrible: terrible,
    };

    return moodMap[str] ?? neutral;
  }

  String get moodName => switch (this) {
        great => S.current.mood_great,
        good => S.current.mood_good,
        neutral => S.current.mood_neutral,
        bad => S.current.mood_bad,
        terrible => S.current.mood_terrible,
      };

  Color get color {
    switch (this) {
      case great:
        return Colors.green;
      case good:
        return Colors.amber;
      case neutral:
        return Colors.grey;
      case bad:
        return Colors.orange;
      case terrible:
        return Colors.red;
    }
  }

  IconData get moodIcon {
    switch (this) {
      case great:
        return FontAwesomeIcons.faceSmileBeam;
      case good:
        return FontAwesomeIcons.faceSmile;
      case neutral:
        return FontAwesomeIcons.faceMeh;
      case bad:
        return FontAwesomeIcons.faceFrown;
      case terrible:
        return FontAwesomeIcons.faceSadTear;
    }
  }

  AnimatedEmojiData get moodAnimatedIcon {
    switch (this) {
      case great:
        return AnimatedEmojis.partyingFace;
      case good:
        return AnimatedEmojis.smileWithBigEyes;
      case neutral:
        return AnimatedEmojis.neutralFace;
      case bad:
        return AnimatedEmojis.sad;
      case terrible:
        return AnimatedEmojis.angry;
    }
  }

  List<String> get listNote => switch (this) {
        Mood.great => [
            S.current.great_suggestion_1,
            S.current.great_suggestion_2
          ],
        Mood.good => [S.current.good_suggestion_1, S.current.good_suggestion_2],
        Mood.neutral => [
            S.current.neutral_suggestion_1,
            S.current.neutral_suggestion_2
          ],
        Mood.bad => [S.current.bad_suggestion_1, S.current.bad_suggestion_2],
        Mood.terrible => [
            S.current.terrible_suggestion_1,
            S.current.terrible_suggestion_2
          ],
      };
}
