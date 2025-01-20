import 'package:json_annotation/json_annotation.dart';

import '../../helpers/enum_helper.dart';

enum AchievementType {
  @JsonValue('accumulation')
  accumulation,
  @JsonValue('time')
  time,
  @JsonValue('streak')
  streak;

  static AchievementType fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? streak;
}
