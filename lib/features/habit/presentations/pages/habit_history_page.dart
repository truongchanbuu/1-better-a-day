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

final logs = [
  HabitHistory(
    id: '1',
    habitId: 'habit1',
    date: DateTime(2024, 12, 4),
    executionStatus: DayStatus.completed.name,
    overallStatus: HabitStatus.achieved.name,
    startTime: DateTime(2024, 1, 1, 7, 0),
    endTime: DateTime(2024, 1, 1, 8, 0),
    duration: const Duration(hours: 1),
    note: 'Great start to the year!',
    rating: 5,
    mood: Mood.good.name,
    quantity: 1.0,
    measurement: GoalUnit.m.name,
  ),
  HabitHistory(
    id: '2',
    habitId: 'habit1',
    date: DateTime(2024, 12, 5),
    executionStatus: DayStatus.completed.name,
    overallStatus: HabitStatus.achieved.name,
    startTime: DateTime(2024, 1, 2, 8, 0),
    endTime: DateTime(2024, 1, 2, 9, 0),
    duration: const Duration(hours: 1),
    note: 'Missed the target.',
    rating: 2,
    mood: Mood.bad.name,
    quantity: 1.0,
    measurement: 'hour',
  ),
  HabitHistory(
    id: '3',
    habitId: 'habit1',
    date: DateTime(2024, 12, 6),
    executionStatus: DayStatus.completed.name,
    overallStatus: HabitStatus.achieved.name,
    startTime: DateTime(2024, 1, 2, 8, 0),
    endTime: DateTime(2024, 1, 2, 9, 0),
    duration: const Duration(hours: 1),
    note: 'Missed the target.',
    rating: 2,
    mood: Mood.bad.name,
    quantity: 1.0,
    measurement: 'hour',
  ),
  HabitHistory(
    id: '4',
    habitId: 'habit1',
    date: DateTime(2024, 12, 7),
    executionStatus: DayStatus.skipped.name,
    overallStatus: HabitStatus.inProgress.name,
    startTime: DateTime(2024, 1, 2, 8, 0),
    endTime: DateTime(2024, 1, 2, 9, 0),
    duration: const Duration(hours: 1),
    note: 'Missed the target.',
    rating: 2,
    mood: Mood.bad.name,
    quantity: 1.0,
    measurement: 'hour',
  ),
  HabitHistory(
    id: '5',
    habitId: 'habit1',
    date: DateTime(2024, 12, 8),
    executionStatus: DayStatus.failed.name,
    overallStatus: HabitStatus.failed.name,
    startTime: DateTime(2024, 1, 2, 8, 0),
    endTime: DateTime(2024, 1, 2, 9, 0),
    duration: const Duration(hours: 1),
    note: 'Missed the target.',
    rating: 2,
    mood: Mood.bad.name,
    quantity: 1.0,
    measurement: 'hour',
  ),
];

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
                  completedDates: DateTimeHelper.getDatesByStatus(
                      logs, DayStatus.completed),
                  failedDates:
                      DateTimeHelper.getDatesByStatus(logs, DayStatus.failed),
                  skippedDates:
                      DateTimeHelper.getDatesByStatus(logs, DayStatus.skipped),
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
                ...logs.map((history) => HistoryItem(history: history)),
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
