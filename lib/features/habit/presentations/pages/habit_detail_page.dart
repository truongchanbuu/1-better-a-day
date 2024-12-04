import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit_category.dart';
import '../../../../core/enums/habit_frequency.dart';
import '../../../../core/enums/habit_icon.dart';
import '../../../../core/enums/habit_status.dart';
import '../../../../core/enums/habit_time_of_day.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../domain/enitites/habit_entity.dart';
import '../widgets/habit_section_container.dart';

final habit = HabitEntity(
  habitId: '1',
  habitTitle: 'Morning Exercise',
  habitDesc: 'Do a 30-minute workout every morning.',
  habitGoal: 'Stay fit and healthy',
  iconName: HabitIcon.exercise.iconName,
  duration: const Duration(minutes: 30),
  frequency: HabitFrequency.daily.name,
  startDate: DateTime(2024, 1, 1),
  timeOfDay: HabitTimeOfDay.morning.name,
  habitCategory: HabitCategory.health.name,
  endDate: DateTime(2024, 12, 31),
  reminderTime: DateTime(2024, 1, 1, 6, 0),
  habitStatus: HabitStatus.inProgress.name,
  habitProgress: 0.67,
);

class HabitDetailPage extends StatelessWidget {
  // final HabitEntity habit;
  const HabitDetailPage({
    super.key,
    // required this.habit,
  });

  static const SizedBox _spacing = SizedBox(height: AppSpacing.marginM);
  static const CrossAxisAlignment _sectionColAlignment =
      CrossAxisAlignment.start;
  static const _habitMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.marginM,
    vertical: AppSpacing.marginL,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grayBackgroundColor,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: _sectionColAlignment,
            children: [
              // General
              HabitSectionContainer(
                margin: _habitMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(title: S.current.habit_detail),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.primaryDark
                            : AppColors.primary,
                        // borderRadius:
                        //     BorderRadius.circular(AppSpacing.circleRadius),
                      ),
                      padding: const EdgeInsets.all(AppSpacing.paddingS),
                      margin: const EdgeInsets.symmetric(
                          vertical: AppSpacing.marginM),
                      child: AnimatedTextKit(
                        repeatForever: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            habit.habitGoal,
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
                    _buildHabitTypes(),
                  ],
                ),
              ),

              // Progress
              HabitSectionContainer(
                margin: _habitMargin.copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: _sectionColAlignment,
                  children: [
                    _SectionTitle(title: S.current.progress_section),
                    _buildStreak(),
                    _spacing,
                    ..._buildDateTimeInfo(context),
                    _spacing,
                    _buildProgressingBar(),
                  ],
                ),
              ),

              // History
              HabitSectionContainer(
                child: Column(
                  crossAxisAlignment: _sectionColAlignment,
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(HabitIcon.getIconData(habit.iconName)),
            const SizedBox(width: AppSpacing.marginS),
            Text(
              habit.habitTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(AppSpacing.paddingS),
          child: Icon(
            Icons.check_circle,
            color: AppColors.lightText,
          ),
        ),
      ],
    );
  }

  Widget _buildHabitTypes() {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        _HabitTypes(habit.habitCategory.toUpperCaseFirstLetter),
        _HabitTypes(habit.timeOfDay.toUpperCaseFirstLetter),
        _HabitTypes(habit.frequency.toUpperCaseFirstLetter),
      ],
    );
  }

  Widget _buildStreak() {
    return ListTile(
      // TODO: NEED TO CHANGE BASED ON THE STATUS
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _IconWithText(
            icon: FontAwesomeIcons.calendarCheck,
            text: S.current.current_streak,
            iconColor: AppColors.success,
            fontSize: AppFontSize.h3,
          ),
          const _IconWithText(
            icon: Icons.emoji_events,
            text: '40 days',
            fontWeight: FontWeight.bold,
            iconColor: Colors.orangeAccent,
            iconSize: 30,
          ),
        ],
      ),
      subtitle: const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.marginS),
        child: _IconWithText(
          icon: Icons.celebration,
          iconColor: Colors.red,
          text: 'Amazing! You\'ve maintained a 50+ day streaks',
          fontSize: AppFontSize.labelLarge,
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
        title: S.current.duration_title,
        subtitle: habit.duration.toDurationString(dropPrefixOrSuffix: true),
        icon: FontAwesomeIcons.hourglassEnd,
        backgroundColor: Colors.purple,
      ),
    ];
  }

  Widget _buildProgressingBar() {
    return Column(
      crossAxisAlignment: _sectionColAlignment,
      children: [
        AnimatedTextKit(
          isRepeatingAnimation: false,
          repeatForever: false,
          animatedTexts: [
            ColorizeAnimatedText(
              '${(habit.habitProgress * 100).toInt()}%',
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h1,
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
        AnimatedProgressBar(
          width: double.infinity,
          gradient: const LinearGradient(
            colors: [Color(0xFF81D4FA), Color(0xFF0288D1), Color(0xAB01579B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          backgroundColor: AppColors.grayBackgroundColor,
          duration: const Duration(milliseconds: 200),
          value: habit.habitProgress,
        ),
      ],
    );
  }
}

class _HabitTypes extends StatelessWidget {
  final String title;
  const _HabitTypes(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.circleRadius),
        color: AppColors.primary.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingM,
        vertical: AppSpacing.paddingXS,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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

class _IconWithText extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;
  final double? iconSize;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const _IconWithText({
    required this.icon,
    required this.text,
    this.iconColor,
    this.iconSize,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(width: AppSpacing.marginS),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: fontColor,
              fontWeight: fontWeight,
              fontSize: fontSize ?? AppFontSize.h1,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
          _IconWithText(
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
