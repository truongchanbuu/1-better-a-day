import '../../../generated/l10n.dart';

enum HabitFailureReason {
  lackOfTime,
  lackOfMotivation,
  healthIssues,
  unexpectedEvents,
  forgetfulness,
  tooDifficult,
  lackOfResources,
  procrastination,
  externalDistractions,
  other;

  String get reasonName {
    switch (this) {
      case HabitFailureReason.lackOfTime:
        return S.current.habit_failure_reason_lack_of_time;
      case HabitFailureReason.lackOfMotivation:
        return S.current.habit_failure_reason_lack_of_motivation;
      case HabitFailureReason.healthIssues:
        return S.current.habit_failure_reason_health_issues;
      case HabitFailureReason.unexpectedEvents:
        return S.current.habit_failure_reason_unexpected_events;
      case HabitFailureReason.forgetfulness:
        return S.current.habit_failure_reason_forgetfulness;
      case HabitFailureReason.tooDifficult:
        return S.current.habit_failure_reason_too_difficult;
      case HabitFailureReason.lackOfResources:
        return S.current.habit_failure_reason_lack_of_resources;
      case HabitFailureReason.procrastination:
        return S.current.habit_failure_reason_procrastination;
      case HabitFailureReason.externalDistractions:
        return S.current.habit_failure_reason_external_distractions;
      case HabitFailureReason.other:
        return S.current.habit_failure_reason_other;
      default:
        return S.current.habit_failure_reason_unknown;
    }
  }
}
