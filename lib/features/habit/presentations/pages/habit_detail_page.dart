import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_frequency.dart';
import '../../../../core/enums/habit/habit_icon.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_goal.dart';
import '../../domain/entities/habit_history.dart';
import '../widgets/habit_section_container.dart';
import '../widgets/habit_streak_calendar.dart';
import '../widgets/reminder_section_item.dart';
import '../widgets/trackers/habit_tracker.dart';
import 'habit_history_page.dart';

var habit = HabitEntity(
  habitId: 'habit1',
  habitTitle: 'Water Drinking',
  habitDesc: 'Drink 2L of water every day.',
  habitGoal: HabitGoal(
    goalId: 'g1',
    habitId: 'habit1',
    goalDesc: 'Stay fit and healthy',
    goalType: GoalType.distance.name,
    targetValue: 10,
    goalUnit: GoalUnit.km.name,
    goalFrequency: 1,
  ),
  iconName: HabitIcon.water.iconName,
  startDate: DateTime(2024, 1, 1),
  timeOfDay: HabitTimeOfDay.morning.name,
  habitCategory: HabitCategory.health.name,
  endDate: DateTime(2024, 12, 31),
  reminderTime: '',
  habitStatus: '',
  habitProgress: 0.48,
);

class HabitDetailPage extends StatelessWidget {
  // final HabitEntity habit;
  const HabitDetailPage({
    super.key,
    // required this.habit,
  });

  static const CrossAxisAlignment _sectionColAlignment =
      CrossAxisAlignment.start;
  static const SizedBox _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? AppColors.primaryDark
            : AppColors.grayBackgroundColor,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: _sectionColAlignment,
            children: [
              // General
              _SectionContainer(
                title: S.current.habit_detail,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? AppColors.primaryDark
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                    ),
                    padding: const EdgeInsets.all(AppSpacing.paddingS),
                    margin: const EdgeInsets.symmetric(
                        vertical: AppSpacing.marginM),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          habit.habitGoal.goalDesc,
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                            color: AppColors.lightText,
                            fontSize: AppFontSize.h3,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    habit.habitDesc,
                    style: const TextStyle(fontSize: AppFontSize.labelLarge),
                  ),
                  _spacing,
                  _buildHabitIcons(),
                ],
              ),

              // Progress
              _SectionContainer(
                title: S.current.progress_section,
                children: [
                  _buildStreak(),
                  _spacing,
                  _buildProgressingBar(context),
                  _spacing,
                  ..._buildDateTimeInfo(context),
                  _spacing,
                  HabitStreakCalendar(
                    disable: true,
                    completedDates: DateTimeHelper.getDatesByStatus(
                        logs, DayStatus.completed),
                    failedDates:
                        DateTimeHelper.getDatesByStatus(logs, DayStatus.failed),
                    skippedDates: DateTimeHelper.getDatesByStatus(
                        logs, DayStatus.skipped),
                    onDaySelected: (firstDate, secondDate) {},
                  ),
                ],
              ),

              // Tracker
              if (habit.habitGoal.goalType != GoalType.custom.name)
                _SectionContainer(
                  width: MediaQuery.of(context).size.width,
                  title: S.current.tracker_section,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.marginM),
                      child: HabitTracker(habitGoal: habit.habitGoal),
                    ),
                  ],
                ),

              // History
              _SectionContainer(
                title: S.current.history_section,
                children: [
                  ...logs.map((history) => _HistoryBriefITem(history: history)),
                  _spacing,
                  _buildAllDetailHistoryButton(context),
                ],
              ),

              // Reminder
              _SectionContainer(
                title: S.current.reminder_section,
                children: const [
                  _spacing,
                  ReminderSectionItem(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            HabitIcon.fromString(habit.iconName).habitIcon,
            const SizedBox(width: AppSpacing.marginS),
            Text(
              habit.habitTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _onShowMenuBottomSheet(context),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  // General Section
  Widget _buildHabitIcons() {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        TextWithCircleBorderContainer(
            title: habit.habitCategory.toUpperCaseFirstLetter),
        TextWithCircleBorderContainer(
            title: habit.timeOfDay.toUpperCaseFirstLetter),
        TextWithCircleBorderContainer(
            title: HabitFrequency.fromNum(habit.habitGoal.goalFrequency)
                .name
                .toUpperCaseFirstLetter),
      ],
    );
  }

  // Progress Section
  Widget _buildStreak() {
    return ListTile(
      // TODO: NEED TO CHANGE BASED ON THE STATUS
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithText(
            icon: FontAwesomeIcons.calendarCheck,
            text: S.current.longest_streak,
            iconColor: AppColors.success,
            fontSize: AppFontSize.h3,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.paddingS)
                .copyWith(right: AppSpacing.paddingM),
            child: const IconWithText(
              icon: Icons.emoji_events,
              text: '40 days',
              fontColor: AppColors.lightText,
              fontWeight: FontWeight.bold,
              iconColor: Colors.amber,
              iconSize: 30,
            ),
          ),
        ],
      ),
      subtitle: const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.marginM),
        child: IconWithText(
          icon: Icons.celebration,
          iconColor: Colors.red,
          text: 'Amazing! You\'ve maintained a 40 day streak',
          fontSize: AppFontSize.bodyLarge,
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  List<Widget> _buildDateTimeInfo(BuildContext context) {
    final String locale = context.locale.languageCode;

    return [
      _DateTimeSectionItem(
        title: S.current.start_date,
        subtitle:
            DateTimeHelper.formatFullDate(habit.startDate, locale: locale),
        icon: FontAwesomeIcons.flagCheckered,
        backgroundColor: Colors.blue,
      ),
      _DateTimeSectionItem(
        title: S.current.end_date,
        subtitle: DateTimeHelper.formatFullDate(habit.endDate, locale: locale),
        icon: FontAwesomeIcons.stopwatch,
        backgroundColor: Colors.green,
      ),
      _DateTimeSectionItem(
        title: S.current.target_title,
        subtitle: habit.habitGoal.target,
        icon: FontAwesomeIcons.bullseye,
        backgroundColor: Colors.purple,
      ),
    ];
  }

  Widget _buildProgressingBar(BuildContext context) {
    final habitProgressPercent = habit.habitProgress * 100;

    return Column(
      crossAxisAlignment: _sectionColAlignment,
      children: [
        AnimatedTextKit(
          isRepeatingAnimation: false,
          repeatForever: false,
          animatedTexts: [
            ColorizeAnimatedText(
              S.current.on_your_way(habitProgressPercent.toInt()),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.bodyLarge,
              ),
              colors: const [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            )
          ],
        ),
        const SizedBox(height: AppSpacing.marginS),
        LinearPercentIndicator(
          backgroundColor: AppColors.grayBackgroundColor,
          padding: EdgeInsets.zero,
          linearGradient: const LinearGradient(
            colors: [Color(0xFF81D4FA), Color(0xFF0288D1), Color(0xAB01579B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barRadius: const Radius.circular(AppSpacing.circleRadius),
          lineHeight: 20,
          percent: habit.habitProgress,
          center: Text(
            '$habitProgressPercent%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: habit.habitProgress < 0.5
                  ? Colors.indigo
                  : AppColors.lightText,
            ),
          ),
        ),
      ],
    );
  }

  // History Section
  Widget _buildAllDetailHistoryButton(BuildContext context) {
    return Bounce(
      duration: AppCommons.buttonBounceDuration,
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.primaryDark : AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        ),
        padding: const EdgeInsets.all(AppSpacing.paddingM),
        child: Text(
          S.current.all_detail_history,
          style: const TextStyle(
            color: AppColors.lightText,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.bodyLarge,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onShowMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => _HabitMenuActions(
              onEdit: () {},
              onDelete: () {},
            ));
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.h1,
      ),
    );
  }
}

class _DateTimeSectionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final Color? backgroundColor;

  const _DateTimeSectionItem({
    required this.title,
    required this.icon,
    required this.subtitle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return HabitSectionContainer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: backgroundColor?.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconWithText(
            icon: icon,
            text: title,
            iconColor: backgroundColor,
            fontColor: backgroundColor,
            fontSize: AppFontSize.labelLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: AppSpacing.marginS),
          Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h4,
            ),
          )
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final double? width;
  final List<Widget> children;

  const _SectionContainer({
    required this.title,
    required this.children,
    this.width,
  });

  static const _habitMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.marginM,
    vertical: AppSpacing.marginL,
  );
  @override
  Widget build(BuildContext context) {
    return HabitSectionContainer(
      width: width,
      margin: _habitMargin.copyWith(top: 0),
      child: Column(
        crossAxisAlignment: HabitDetailPage._sectionColAlignment,
        children: [
          _SectionTitle(title: title),
          ...children,
        ],
      ),
    );
  }
}

class _HistoryBriefITem extends StatelessWidget {
  final HabitHistory history;
  const _HistoryBriefITem({required this.history});

  static const String _unAchievedTaskTime = '__:__';
  @override
  Widget build(BuildContext context) {
    final habitStatus = HabitStatus.fromString(history.executionStatus);
    final iconData = habitStatus.habitStatusIcon;
    final iconColor = habitStatus.habitStatusColor;
    final String? completedTime =
        history.endTime?.toMoment().formatTimeWithSeconds();

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        iconData,
        color: iconColor,
      ),
      title: Text(
        DateTimeHelper.formatFullDate(
          history.date,
          locale: context.locale.languageCode,
        ),
      ),
      trailing: IconWithText(
        icon: FontAwesomeIcons.clockRotateLeft,
        text: completedTime ?? _unAchievedTaskTime,
        fontSize: AppFontSize.labelLarge,
        iconSize: 20,
      ),
    );
  }
}

class _HabitMenuActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _HabitMenuActions({
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onEdit,
          leading: const Icon(FontAwesomeIcons.penToSquare),
          title: Text(
            S.current.edit_button,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: onDelete,
          leading: const Icon(FontAwesomeIcons.trash, color: AppColors.error),
          title: Text(
            S.current.delete_button,
            style: const TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
