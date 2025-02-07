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
  @JsonValue('minute')
  minute,
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
  @JsonValue('glasses')
  glasses,
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
        minute => S.current.minute_unit,
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
        glasses => S.current.glass_unit
      };

  IconData get unitIcon => switch (this) {
        reps => FontAwesomeIcons.dumbbell,
        sets => FontAwesomeIcons.layerGroup,
        l => FontAwesomeIcons.droplet,
        ml => FontAwesomeIcons.droplet,
        second => FontAwesomeIcons.stopwatch,
        minute => FontAwesomeIcons.clock,
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
        glasses => FontAwesomeIcons.glasses,
      };

  Color get unitColor => switch (this) {
        reps => Colors.blue,
        sets => Colors.red,
        l => Colors.blue,
        ml => Colors.blue,
        second => Colors.yellow,
        minute => Colors.orange,
        hour => Colors.deepOrange,
        page => Colors.purple,
        cm => Colors.pink,
        km => Colors.cyan,
        m => Colors.teal,
        steps => Colors.indigo,
        miles => Colors.amber,
        custom => Colors.brown,
        times => Colors.blue,
        day => Colors.blue,
        glasses => Colors.blue,
      };

  String get shortName {
    switch (this) {
      case reps:
        return 'reps';
      case sets:
        return 'sets';
      case l:
        return 'l';
      case ml:
        return 'ml';
      case day:
        return 'd';
      case second:
        return 's';
      case minute:
        return 'min';
      case hour:
        return 'hr';
      case page:
        return 'pg';
      case cm:
        return 'cm';
      case km:
        return 'km';
      case m:
        return 'm';
      case steps:
        return 'steps';
      case miles:
        return 'miles';
      case times:
        return 'times';
      case glasses:
        return 'gls';
      case custom:
        return 'cust';
    }
  }
}

class UnitConverter {
  static const Map<GoalUnit, double> unitToBase = {
    GoalUnit.km: 1000.0, // 1 km = 1000 m
    GoalUnit.m: 1.0, // 1 m
    GoalUnit.cm: 0.01, // 1 cm = 0.01 m
    GoalUnit.miles: 1600.0,
    GoalUnit.l: 1000.0, // 1 liter = 1000 ml
    GoalUnit.ml: 1.0, // 1 ml là đơn vị cơ sở
    GoalUnit.glasses: 250.0, // 1 glass = 250 ml
    GoalUnit.page: 1,
    GoalUnit.reps: 1,
    GoalUnit.sets: 1,
    GoalUnit.hour: 60,
    GoalUnit.minute: 1,
    GoalUnit.second: 1 / 60.0,
    GoalUnit.times: 1,
    GoalUnit.steps: 1,
    GoalUnit.day: 1,
  };

  static double normalizeValue(GoalUnit unit, double value) {
    if (!unitToBase.containsKey(unit)) {
      throw ArgumentError("Unsupported unit: $unit");
    }

    return value * unitToBase[unit]!;
  }

  static double convert(GoalUnit fromUnit, GoalUnit toUnit, double value) {
    final normalizedValue = normalizeValue(fromUnit, value);
    final toBase = unitToBase[toUnit];
    if (toBase == null) {
      throw ArgumentError("Unsupported unit: $toUnit");
    }
    return normalizedValue / toBase;
  }
}
