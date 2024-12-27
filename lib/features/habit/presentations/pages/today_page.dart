import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import '../../domain/helper/shared_habit_action.dart';
import '../widgets/today_habit_item.dart';
import '../widgets/today_quote.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => SharedHabitAction.showAddHabitOptions(context),
          shape: const CircleBorder(),
          tooltip: S.current.add_habit,
          child: const Icon(FontAwesomeIcons.plus),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.marginM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${HabitTimeOfDay.periodOfTheDay.greeting}, ${currentUser.username?.isEmpty ?? true ? S.current.friend_title : currentUser.username}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.h2,
                  ),
                ),
                const TodayQuote(),
                const SizedBox(height: AppSpacing.marginL),
                const _TodayCalendar(),
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
}

class _TodayCalendar extends StatelessWidget {
  const _TodayCalendar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusS),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: TableCalendar(
        locale: context.locale.languageCode,
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
              )),
        ),
      ),
    );
  }
}
