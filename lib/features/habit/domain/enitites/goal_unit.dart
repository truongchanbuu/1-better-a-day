import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/helpers/enum_helper.dart';

enum GoalUnit {
  reps,
  sets,
  l,
  ml,
  second,
  minute,
  hour,
  day,
  page,
  cm,
  km,
  m,
  steps,
  miles,
  custom();

  final String? unitName;
  const GoalUnit([this.unitName]);

  static GoalUnit fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? GoalUnit.custom;

  IconData get unitIcon => switch (this) {
        GoalUnit.reps => FontAwesomeIcons.dumbbell,
        GoalUnit.sets => FontAwesomeIcons.layerGroup,
        GoalUnit.l => FontAwesomeIcons.droplet,
        GoalUnit.ml => FontAwesomeIcons.droplet,
        GoalUnit.second => FontAwesomeIcons.stopwatch,
        GoalUnit.minute => FontAwesomeIcons.clock,
        GoalUnit.hour => FontAwesomeIcons.hourglassHalf,
        GoalUnit.day => FontAwesomeIcons.calendarDay,
        GoalUnit.page => FontAwesomeIcons.book,
        GoalUnit.cm => FontAwesomeIcons.rulerHorizontal,
        GoalUnit.km => FontAwesomeIcons.route,
        GoalUnit.m => FontAwesomeIcons.rulerHorizontal,
        GoalUnit.steps => FontAwesomeIcons.personWalking,
        GoalUnit.miles => FontAwesomeIcons.road,
        GoalUnit.custom => FontAwesomeIcons.gears,
      };
}
