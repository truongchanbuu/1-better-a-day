import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum HabitStatus {
  failed,
  inProgress,
  paused,
  skipped,
  achieved,
  pending;

  static HabitStatus fromString(String str) =>
      EnumHelper.fromString(values, str) ?? HabitStatus.pending;

  String get statusName {
    switch (this) {
      case HabitStatus.failed:
        return S.current.habit_status_failed;
      case HabitStatus.inProgress:
        return S.current.habit_status_in_progress;
      case HabitStatus.paused:
        return S.current.habit_status_paused;
      case HabitStatus.skipped:
        return S.current.habit_status_skipped;
      case HabitStatus.achieved:
        return S.current.habit_status_achieved;
      case HabitStatus.pending:
        return S.current.habit_status_pending;
      default:
        return S.current.habit_status_unknown;
    }
  }

  IconData get habitStatusIcon {
    switch (this) {
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

      case pending:
        return FontAwesomeIcons.hourglassHalf;

      default:
        return Icons.help_outline;
    }
  }

  Color get habitStatusColor {
    switch (this) {
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

      case HabitStatus.pending:
        return Colors.yellow;

      default:
        return Colors.black;
    }
  }
}
