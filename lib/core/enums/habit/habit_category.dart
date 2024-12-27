import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../helpers/enum_helper.dart';

enum HabitCategory {
  health,
  education,
  productivity,
  mindfulness,
  lifestyle,
  nutrition,
  social,
  finance,
  creativity,
  environmental,
  custom;

  IconData get iconData {
    switch (this) {
      case health:
        return Icons.favorite;
      case education:
        return Icons.school;
      case productivity:
        return Icons.work;
      case mindfulness:
        return Icons.self_improvement;
      case lifestyle:
        return Icons.style;
      case nutrition:
        return Icons.restaurant;
      case social:
        return Icons.people;
      case finance:
        return Icons.attach_money;
      case creativity:
        return Icons.brush;
      case environmental:
        return Icons.eco;
      case custom:
        return Icons.star;
      default:
        return Icons.help;
    }
  }

  static HabitCategory fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? custom;

  String get categoryName {
    switch (this) {
      case health:
        return S.current.habit_category_health;
      case education:
        return S.current.habit_category_learning;
      case productivity:
        return S.current.habit_category_productivity;
      case mindfulness:
        return S.current.habit_category_mindfulness;
      case lifestyle:
        return S.current.habit_category_lifestyle;
      case nutrition:
        return S.current.habit_category_nutrition;
      case social:
        return S.current.habit_category_social;
      case finance:
        return S.current.habit_category_finance;
      case creativity:
        return S.current.habit_category_creativity;
      case environmental:
        return S.current.habit_category_environmental;
      default:
        return S.current.habit_category_unknown;
    }
  }

  static HabitCategory? fromMultiLangString(String? str) {
    final categoryMap = {
      S.current.habit_category_health: health,
      S.current.habit_category_learning: education,
      S.current.habit_category_productivity: productivity,
      S.current.habit_category_mindfulness: mindfulness,
      S.current.habit_category_lifestyle: lifestyle,
      S.current.habit_category_nutrition: nutrition,
      S.current.habit_category_social: social,
      S.current.habit_category_finance: finance,
      S.current.habit_category_creativity: creativity,
      S.current.habit_category_environmental: environmental,
    };

    return categoryMap[str];
  }

  Color get color {
    switch (this) {
      case health:
        return Colors.green;
      case education:
        return Colors.blue;
      case productivity:
        return Colors.orange;
      case mindfulness:
        return Colors.purple;
      case lifestyle:
        return Colors.teal;
      case nutrition:
        return Colors.red;
      case social:
        return Colors.pink;
      case finance:
        return Colors.brown;
      case creativity:
        return Colors.yellow;
      case environmental:
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }
}
