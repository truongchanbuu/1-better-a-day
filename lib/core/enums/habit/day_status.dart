import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum DayStatus {
  completed,
  failed,
  skipped,
  paused,
  inProgress;

  IconData get statusIcon {
    switch (this) {
      case completed:
        return Icons.check_circle;
      case failed:
        return Icons.cancel;
      case skipped:
        return Icons.fast_forward;
      case paused:
        return Icons.pause_circle_filled;
      case inProgress:
        return Icons.hourglass_full;
      default:
        return Icons.help;
    }
  }

  Color get statusColor {
    switch (this) {
      case completed:
        return Colors.green; // #4CAF50
      case failed:
        return Colors.red; // #F44336
      case skipped:
        return Colors.orange; // #FF9800
      case paused:
        return Colors.blue; // #2196F3
      case inProgress:
        return Colors.yellow; // #FFEB3B
      default:
        return Colors.grey;
    }
  }

  String get statusName {
    switch (this) {
      case failed:
        return S.current.status_failed;
      case inProgress:
        return S.current.status_in_progress;
      case paused:
        return S.current.status_paused;
      case skipped:
        return S.current.status_skipped;
      default:
        return S.current.status_unkown;
    }
  }

  static DayStatus fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? DayStatus.inProgress;

  static DayStatus fromMultiLangString(String? str) {
    final statusMap = {
      S.current.status_failed: failed,
      S.current.status_in_progress: inProgress,
      S.current.status_paused: paused,
      S.current.status_skipped: skipped,
    };

    return statusMap[str] ?? inProgress;
  }
}
