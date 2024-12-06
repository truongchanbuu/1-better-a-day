import '../../../../core/helpers/enum_helper.dart';

enum GoalUnit {
  reps,
  sets,
  l,
  ml,
  second,
  minute,
  hour,
  day,
  page,
  cm,
  km,
  m,
  steps,
  miles,
  custom;

  static GoalUnit fromString(String str) =>
      EnumHelper.fromString(values, str) ?? GoalUnit.custom;
}
