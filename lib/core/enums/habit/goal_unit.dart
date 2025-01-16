import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum GoalUnit {
  @JsonValue('reps')
  reps,
  @JsonValue('sets')
  sets,
  @JsonValue('l')
  l,
  @JsonValue('ml')
  ml,
  @JsonValue('day')
  day,
  @JsonValue('second')
  second,
  @JsonValue('minutes')
  minutes,
  @JsonValue('hour')
  hour,
  @JsonValue('page')
  page,
  @JsonValue('cm')
  cm,
  @JsonValue('km')
  km,
  @JsonValue('m')
  m,
  @JsonValue('steps')
  steps,
  @JsonValue('miles')
  miles,
  @JsonValue('times')
  times,
  @JsonValue('custom')
  custom;

  static GoalUnit fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? custom;

  static GoalUnit fromMultiLanguageString(String? str) {
    final langMap = {
      for (var entry in values.asMap().entries)
        values[entry.key].unitName: entry.value
    };

    return langMap[str] ?? custom;
  }

  String get unitName => switch (this) {
        reps => S.current.reps_unit,
        sets => S.current.sets_unit,
        l => S.current.l_unit,
        ml => S.current.ml_unit,
        second => S.current.second_unit,
        minutes => S.current.minute_unit,
        hour => S.current.hour_unit,
        page => S.current.page_unit,
        cm => S.current.cm_unit,
        km => S.current.km_unit,
        steps => S.current.steps_unit,
        miles => S.current.miles_unit,
        m => S.current.m_unit,
        custom => S.current.custom_unit,
        times => S.current.times_unit,
        day => S.current.day_unit,
      };

  IconData get unitIcon => switch (this) {
        reps => FontAwesomeIcons.dumbbell,
        sets => FontAwesomeIcons.layerGroup,
        l => FontAwesomeIcons.droplet,
        ml => FontAwesomeIcons.droplet,
        second => FontAwesomeIcons.stopwatch,
        minutes => FontAwesomeIcons.clock,
        hour => FontAwesomeIcons.hourglassHalf,
        page => FontAwesomeIcons.book,
        cm => FontAwesomeIcons.rulerHorizontal,
        km => FontAwesomeIcons.route,
        m => FontAwesomeIcons.rulerHorizontal,
        steps => FontAwesomeIcons.personWalking,
        miles => FontAwesomeIcons.road,
        custom => FontAwesomeIcons.gears,
        times => FontAwesomeIcons.repeat,
        day => FontAwesomeIcons.calendarDay,
      };

  Color get unitColor => switch (this) {
        reps => Colors.blue,
        sets => Colors.red,
        l => Colors.green,
        ml => Colors.lightGreen,
        second => Colors.yellow,
        minutes => Colors.orange,
        hour => Colors.deepOrange,
        page => Colors.purple,
        cm => Colors.pink,
        km => Colors.cyan,
        m => Colors.teal,
        steps => Colors.indigo,
        miles => Colors.amber,
        custom => Colors.brown,
        times => Colors.blue,
        GoalUnit.day => Colors.blue,
      };
}
