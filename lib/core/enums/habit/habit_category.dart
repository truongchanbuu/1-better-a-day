import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

enum HabitCategory {
  health,
  learning,
  productivity,
  mindfulness,
  lifestyle,
  nutrition,
  social,
  finance,
  creativity,
  environmental;

  String get categoryName {
    switch (this) {
      case HabitCategory.health:
        return S.current.habit_category_health;
      case HabitCategory.learning:
        return S.current.habit_category_learning;
      case HabitCategory.productivity:
        return S.current.habit_category_productivity;
      case HabitCategory.mindfulness:
        return S.current.habit_category_mindfulness;
      case HabitCategory.lifestyle:
        return S.current.habit_category_lifestyle;
      case HabitCategory.nutrition:
        return S.current.habit_category_nutrition;
      case HabitCategory.social:
        return S.current.habit_category_social;
      case HabitCategory.finance:
        return S.current.habit_category_finance;
      case HabitCategory.creativity:
        return S.current.habit_category_creativity;
      case HabitCategory.environmental:
        return S.current.habit_category_environmental;
      default:
        return S.current.habit_category_unknown;
    }
  }

  static HabitCategory? fromMultiLangString(String? str) {
    final categoryMap = {
      S.current.habit_category_health: HabitCategory.health,
      S.current.habit_category_learning: HabitCategory.learning,
      S.current.habit_category_productivity: HabitCategory.productivity,
      S.current.habit_category_mindfulness: HabitCategory.mindfulness,
      S.current.habit_category_lifestyle: HabitCategory.lifestyle,
      S.current.habit_category_nutrition: HabitCategory.nutrition,
      S.current.habit_category_social: HabitCategory.social,
      S.current.habit_category_finance: HabitCategory.finance,
      S.current.habit_category_creativity: HabitCategory.creativity,
      S.current.habit_category_environmental: HabitCategory.environmental,
    };

    return categoryMap[str];
  }

  Color get color {
    switch (this) {
      case HabitCategory.health:
        return Colors.green;
      case HabitCategory.learning:
        return Colors.blue;
      case HabitCategory.productivity:
        return Colors.orange;
      case HabitCategory.mindfulness:
        return Colors.purple;
      case HabitCategory.lifestyle:
        return Colors.teal;
      case HabitCategory.nutrition:
        return Colors.red;
      case HabitCategory.social:
        return Colors.pink;
      case HabitCategory.finance:
        return Colors.brown;
      case HabitCategory.creativity:
        return Colors.yellow;
      case HabitCategory.environmental:
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }
}
