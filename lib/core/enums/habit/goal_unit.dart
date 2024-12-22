import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum GoalUnit {
  reps,
  sets,
  l,
  ml,
  second,
  minute,
  hour,
  page,
  cm,
  km,
  m,
  steps,
  miles,
  custom;

  static GoalUnit fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? GoalUnit.custom;

  String get unitName => switch (this) {
        GoalUnit.reps => S.current.reps_unit,
        GoalUnit.sets => S.current.sets_unit,
        GoalUnit.l => S.current.l_unit,
        GoalUnit.ml => S.current.ml_unit,
        GoalUnit.second => S.current.second_unit,
        GoalUnit.minute => S.current.minute_unit,
        GoalUnit.hour => S.current.hour_unit,
        GoalUnit.page => S.current.page_unit,
        GoalUnit.cm => S.current.cm_unit,
        GoalUnit.km => S.current.km_unit,
        GoalUnit.steps => S.current.steps_unit,
        GoalUnit.miles => S.current.miles_unit,
        GoalUnit.custom => S.current.custom_unit,
        GoalUnit.m => S.current.m_unit,
      };

  IconData get unitIcon => switch (this) {
        GoalUnit.reps => FontAwesomeIcons.dumbbell,
        GoalUnit.sets => FontAwesomeIcons.layerGroup,
        GoalUnit.l => FontAwesomeIcons.droplet,
        GoalUnit.ml => FontAwesomeIcons.droplet,
        GoalUnit.second => FontAwesomeIcons.stopwatch,
        GoalUnit.minute => FontAwesomeIcons.clock,
        GoalUnit.hour => FontAwesomeIcons.hourglassHalf,
        GoalUnit.page => FontAwesomeIcons.book,
        GoalUnit.cm => FontAwesomeIcons.rulerHorizontal,
        GoalUnit.km => FontAwesomeIcons.route,
        GoalUnit.m => FontAwesomeIcons.rulerHorizontal,
        GoalUnit.steps => FontAwesomeIcons.personWalking,
        GoalUnit.miles => FontAwesomeIcons.road,
        GoalUnit.custom => FontAwesomeIcons.gears,
      };
}
