import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../generated/l10n.dart';
import '../widgets/today_habit_item.dart';
import '../widgets/today_quote.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(FontAwesomeIcons.plus),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.marginM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${HabitTimeOfDay.periodOfTheDay.greeting}, friend',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.h2,
                  ),
                ),
                const TodayQuote(),
                const SizedBox(height: AppSpacing.marginL),
                _buildCalendar(),
                const SizedBox(height: AppSpacing.marginM),
                Text(
                  S.current.today_tasks,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.h2,
                  ),
                ),
                ...List.generate(5, (index) => const TodayHabitItem()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: TableCalendar(
        calendarFormat: CalendarFormat.week,
        focusedDay: DateTime.now(),
        firstDay: DateTime.now().subtract(const Duration(days: 30)),
        lastDay: DateTime.now(),
        headerVisible: false,
        currentDay: DateTime.now(),
        calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSpacing.circleRadius),
                ))),
      ),
    );
  }
}
