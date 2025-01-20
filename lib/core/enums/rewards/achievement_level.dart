import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../helpers/enum_helper.dart';

enum AchievementLevel {
  @JsonValue('common')
  common,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary;

  Color get color {
    switch (this) {
      case AchievementLevel.common:
        return Colors.grey;
      case AchievementLevel.rare:
        return Colors.blue;
      case AchievementLevel.epic:
        return Colors.purple;
      case AchievementLevel.legendary:
        return Colors.orange;
    }
  }

  static AchievementLevel fromString(String? str) =>
      EnumHelper.fromString(values, str?.trim().toLowerCase()) ?? common;
}
