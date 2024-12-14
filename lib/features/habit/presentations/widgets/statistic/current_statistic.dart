import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/mood.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/domain/entities/tab_bar_item.dart';
import '../../../domain/entities/mood_entry.dart';
import '../../pages/habit_statistic_page.dart';
import 'charts/chart_tab_bar.dart';
import 'charts/habit_general_pie_chart.dart';
import 'charts/habit_time_slot_heat_map.dart';
import 'charts/weekly_mood_bar.dart';
import 'statistic_item.dart';

class CurrentStatistic extends StatelessWidget {
  const CurrentStatistic({super.key});

  static final List<TabBarItem> tabData = [
    TabBarItem(
        title: S.current.time_slot_heatmap, icon: FontAwesomeIcons.timeline),
    TabBarItem(title: S.current.weekly_mood, icon: FontAwesomeIcons.calendar),
    TabBarItem(title: S.current.most_mood, icon: FontAwesomeIcons.chartPie),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticItem(
          title: S.current.longest_streak,
          subTitle: S.current.total_streak(20),
          figureColor: Colors.red,
          iconColor: Colors.red,
          icon: FontAwesomeIcons.road,
        ),
        StatisticItem(
          title: S.current.current_progress,
          subTitle: '80%',
          figureColor: AppColors.primary,
          iconColor: AppColors.primary,
          icon: FontAwesomeIcons.barsProgress,
        ),
        StatisticItem(
          title: S.current.best_time,
          subTitle: DateTimeHelper.timeSlots.first,
          iconColor: AppColors.primary,
          subTitleColor: AppColors.primary,
          icon: FontAwesomeIcons.businessTime,
        ),
        StatisticItem(
          title: S.current.avg_time,
          subTitle: '30 min',
          iconColor: Colors.green,
          icon: FontAwesomeIcons.clock,
        ),
        StatisticItem(
          title: S.current.most_mood,
          subTitle: Mood.good.name.toUpperCaseFirstLetter,
          iconColor: Mood.good.color,
          subTitleColor: Mood.good.color,
          icon: Mood.good.moodIcon,
        ),
        StatisticItem(
          title: S.current.miss_title,
          subTitle: '30% (3 ${S.current.day_title})',
          figureColor: AppColors.error,
          iconColor: AppColors.error,
          icon: FontAwesomeIcons.calendarXmark,
        ),
        StatisticItem(
          title: S.current.most_reason,
          subTitle: S.current.habit_failure_reason_lack_of_motivation,
          figureColor: AppColors.error,
          iconColor: AppColors.error,
          icon: FontAwesomeIcons.triangleExclamation,
        ),
        StatisticItem(
          title: S.current.pause_statistic_page,
          subTitle: '30% (3 ${S.current.day_title})',
          figureColor: AppColors.warning,
          iconColor: AppColors.warning,
          icon: FontAwesomeIcons.circlePause,
        ),
        StatisticItem(
          title: S.current.most_reason,
          subTitle: S.current.habit_pause_reason_health_issues,
          figureColor: AppColors.warning,
          iconColor: AppColors.warning,
          icon: FontAwesomeIcons.personCircleQuestion,
        ),
        const SizedBox(height: AppSpacing.marginM),

        // Graphs
        ChartTabBar(
          tabData: tabData,
          defaultHeightRatio: 0.45,
          heightRatios: {
            1: [''].isEmpty ? 0.12 : 0.26,
            2: 0.57,
          },
          contentWidgets: [
            const _HabitTimeSlotHeatMap(),
            _WeeklyMoodStatusBar(),
            const _MoodPieChart()
          ],
        ),
      ],
    );
  }
}

class _HabitTimeSlotHeatMap extends StatelessWidget {
  const _HabitTimeSlotHeatMap();

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.time_slot_heatmap,
      chart: HabitTimeSlotHeatMap(),
    );
  }
}

class _WeeklyMoodStatusBar extends StatelessWidget {
  _WeeklyMoodStatusBar();

  final moodEntries = [
    MoodEntry(date: DateTime(2024, 12, 9), mood: Mood.great),
    MoodEntry(date: DateTime(2024, 12, 10), mood: Mood.good),
    MoodEntry(date: DateTime(2024, 12, 12), mood: Mood.neutral),
  ];

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.weekly_mood,
      chart: Expanded(child: WeeklyMoodBar(moodEntries: moodEntries)),
    );
  }
}

class _MoodPieChart extends StatelessWidget {
  const _MoodPieChart();

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.mood_distribution,
      chart: HabitGeneralPieChart(
        dataItems: Mood.values
            .map((mood) => PieChartDataItem(
                  color: mood.color,
                  value: Random().nextInt(100).toDouble(),
                  label: mood.name.toUpperCaseFirstLetter,
                ))
            .toList(),
      ),
    );
  }
}
