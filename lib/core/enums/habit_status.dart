import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/enum_helper.dart';

enum HabitStatus {
  completed,
  failed,
  inProgress,
  paused,
  skipped,
  achieved,
  missed,
  pending,
  notStart;

  static HabitStatus fromString(String str) =>
      EnumHelper.fromString(values, str) ?? HabitStatus.pending;

  static IconData getHabitStatusIcon(HabitStatus? status) {
    switch (status) {
      case completed:
        return FontAwesomeIcons.circleCheck;
      case failed:
        return FontAwesomeIcons.circleXmark;
      case inProgress:
        return FontAwesomeIcons.spinner;
      case paused:
        return Icons.pause_circle;
      case skipped:
        return FontAwesomeIcons.forward;
      case achieved:
        return FontAwesomeIcons.trophy;
      case missed:
        return FontAwesomeIcons.circleExclamation;
      case pending:
        return FontAwesomeIcons.hourglassHalf;
      case notStart:
        return Icons.do_not_disturb_on;
      default:
        return Icons.help_outline;
    }
  }

  static Color getHabitStatusColor(HabitStatus? status) {
    switch (status) {
      case HabitStatus.completed:
        return Colors.green;
      case HabitStatus.failed:
        return Colors.red;
      case HabitStatus.inProgress:
        return Colors.blue;
      case HabitStatus.paused:
        return Colors.grey;
      case HabitStatus.skipped:
        return Colors.orange;
      case HabitStatus.achieved:
        return Colors.amber;
      case HabitStatus.missed:
        return Colors.deepOrange;
      case HabitStatus.pending:
        return Colors.yellow;
      case HabitStatus.notStart:
        return Colors.lightBlue;
      default:
        return Colors.black;
    }
  }
}
