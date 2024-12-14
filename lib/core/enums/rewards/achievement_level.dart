import 'package:flutter/material.dart';

enum AchievementLevel {
  common,
  rare,
  epic,
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
      default:
        return Colors.black;
    }
  }
}
