import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum DayStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('skipped')
  skipped,
  @JsonValue('inProgress')
  inProgress;

  IconData get statusIcon {
    switch (this) {
      case completed:
        return Icons.check_circle;
      case failed:
        return Icons.cancel;
      case skipped:
        return Icons.fast_forward;
      case inProgress:
        return Icons.sync;
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
      case inProgress:
        return Colors.blue; // #FFEB3B
    }
  }

  String get statusName {
    switch (this) {
      case completed:
        return S.current.status_completed;
      case failed:
        return S.current.status_failed;
      case inProgress:
        return S.current.status_in_progress;
      case skipped:
        return S.current.status_skipped;
    }
  }

  static DayStatus fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? DayStatus.inProgress;

  static DayStatus fromMultiLangString(String? str) {
    final statusMap = {
      S.current.status_completed: completed,
      S.current.status_failed: failed,
      S.current.status_in_progress: inProgress,
      S.current.status_skipped: skipped,
    };

    return statusMap[str] ?? inProgress;
  }
}
