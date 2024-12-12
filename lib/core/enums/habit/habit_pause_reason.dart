import '../../../generated/l10n.dart';

enum HabitPauseReason {
  lackOfTime,
  lackOfMotivation,
  healthIssues,
  unexpectedEvents,
  needForRest,
  reassessment,
  other;

  String get pauseReasonName {
    switch (this) {
      case HabitPauseReason.lackOfTime:
        return S.current.habit_pause_reason_lack_of_time;
      case HabitPauseReason.lackOfMotivation:
        return S.current.habit_pause_reason_lack_of_motivation;
      case HabitPauseReason.healthIssues:
        return S.current.habit_pause_reason_health_issues;
      case HabitPauseReason.unexpectedEvents:
        return S.current.habit_pause_reason_unexpected_events;
      case HabitPauseReason.needForRest:
        return S.current.habit_pause_reason_need_for_rest;
      case HabitPauseReason.reassessment:
        return S.current.habit_pause_reason_reassessment;
      case HabitPauseReason.other:
        return S.current.habit_pause_reason_other;
      default:
        return S.current.habit_pause_reason_unknown;
    }
  }
}
