import '../helpers/enum_helper.dart';

enum GoalType {
  completion,
  count,
  distance,
  duration,
  custom;

  static GoalType fromString(String str) =>
      EnumHelper.fromString(values, str) ?? GoalType.custom;
}
