import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';

import '../../helpers/enum_helper.dart';

enum HabitIcon {
  water('water'),
  exercise('fitness'),
  waking('wake_up'),
  reading('book'),
  custom('');

  final String iconName;
  const HabitIcon(this.iconName);

  Color get habitColor => switch (this) {
        HabitIcon.water => Colors.blue,
        HabitIcon.exercise => Colors.green,
        HabitIcon.waking => Colors.orange,
        HabitIcon.reading => Colors.brown,
        HabitIcon.custom => Colors.grey,
      };

  static HabitIcon fromString(String? str) =>
      EnumHelper.fromString(values, str) ?? custom;

  Iconify get habitIcon => switch (this) {
        HabitIcon.water => const Iconify(
            Mdi.water_drop,
            color: Colors.blue,
          ),
        HabitIcon.exercise => const Iconify(
            Mdi.human_run,
            color: Colors.green,
          ),
        HabitIcon.waking => const Iconify(
            Mdi.alarm,
            color: Colors.orange,
          ),
        HabitIcon.reading => const Iconify(
            Mdi.book_open,
            color: Colors.black,
          ),
        HabitIcon.custom => const Iconify(
            Mdi.help_circle,
            color: Colors.purple,
          ),
      };
}
