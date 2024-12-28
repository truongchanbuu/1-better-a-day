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
        return S.current.status_failed;
      case HabitStatus.inProgress:
        return S.current.status_in_progress;
      case HabitStatus.paused:
        return S.current.status_paused;
      case HabitStatus.skipped:
        return S.current.status_skipped;
      case HabitStatus.achieved:
        return S.current.status_achieved;
      case HabitStatus.pending:
        return S.current.status_pending;
      default:
        return S.current.status_unkown;
    }
  }

  static HabitStatus fromMultiLangString(String? str) {
    final statusMap = {
      S.current.status_failed: failed,
      S.current.status_in_progress: inProgress,
      S.current.status_paused: paused,
      S.current.status_skipped: skipped,
      S.current.status_achieved: achieved,
      S.current.status_pending: pending,
    };

    return statusMap[str] ?? pending;
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
