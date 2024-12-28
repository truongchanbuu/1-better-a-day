import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/enums/habit/mood.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../domain/entities/habit_history.dart';
import '../widgets/habit_streak_calendar.dart';
import '../widgets/habit_history/history_item.dart';
import '../widgets/search_filter/habit_date_picker.dart';
import '../widgets/search_filter/filter_item.dart';

class HabitHistoryPage extends StatefulWidget {
  const HabitHistoryPage({super.key});

  @override
  State<HabitHistoryPage> createState() => _HabitHistoryPageState();
}

class _HabitHistoryPageState extends State<HabitHistoryPage> {
  bool _isDateSelectedShown = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(S.current.history_section)),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: AppSpacing.marginS, horizontal: AppSpacing.marginM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HabitStreakCalendar(
                  completedDates:
                      DateTimeHelper.getDatesByStatus([], DayStatus.completed),
                  failedDates:
                      DateTimeHelper.getDatesByStatus([], DayStatus.failed),
                  skippedDates:
                      DateTimeHelper.getDatesByStatus([], DayStatus.skipped),
                  onDaySelected: (date, status) {},
                ),
                const SizedBox(height: AppSpacing.marginM),
                Text(
                  S.current.detail_section,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.h1,
                  ),
                ),
                const SizedBox(height: AppSpacing.marginS),
                _FilterBar(
                  onDateSelectedShown: () => setState(
                      () => _isDateSelectedShown = !_isDateSelectedShown),
                ),
                AnimatedSwitcherPlus.translationRight(
                  duration: const Duration(milliseconds: 500),
                  child: _isDateSelectedShown
                      ? const HabitDatePicker()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: AppSpacing.marginM),
                ...[].map((history) => HistoryItem(history: history)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final VoidCallback? onDateSelectedShown;
  const _FilterBar({this.onDateSelectedShown});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterItem(
            width: 150,
            title: S.current.status_title,
            items: DayStatus.values
                .map((e) => e.name.toUpperCaseFirstLetter)
                .toList(),
          ),
          FilterItem(
            width: 150,
            title: S.current.mood_title,
            items:
                Mood.values.map((e) => e.name.toUpperCaseFirstLetter).toList(),
          ),
          FilterItem(
            width: 150,
            title: S.current.date_title,
            items: const [],
            iconStyleData: const IconStyleData(icon: Icon(null)),
            onTap: onDateSelectedShown,
          ),
        ],
      ),
    );
  }
}
