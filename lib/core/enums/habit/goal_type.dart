import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum GoalType {
  completion,
  count,
  distance,
  duration,
  custom;

  static GoalType fromString(String str) =>
      EnumHelper.fromString(values, str) ?? GoalType.custom;

  static GoalType fromMultiLangString(String str) {
    final goalTypeMap = {
      S.current.goal_completion: GoalType.completion,
      S.current.goal_count: GoalType.count,
      S.current.goal_distance: GoalType.distance,
      S.current.goal_duration: GoalType.duration,
      S.current.goal_custom: GoalType.custom,
    };
    return goalTypeMap[str] ?? GoalType.custom;
  }

  String get typeName => switch (this) {
        GoalType.completion => S.current.goal_completion,
        GoalType.count => S.current.goal_count,
        GoalType.distance => S.current.goal_distance,
        GoalType.duration => S.current.goal_duration,
        GoalType.custom => S.current.goal_custom,
      };
}
