import 'dart:math';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit_category.dart';
import '../../../../../generated/l10n.dart';
import '../../pages/habit_statistic_page.dart';
import 'charts/category_distribution_chart.dart';
import 'charts/chart_tab_bar.dart';
import 'charts/completion_bar_chart.dart';
import 'charts/habit_general_pie_chart.dart';
import 'statistic_item.dart';

class GeneralStatistics extends StatefulWidget {
  const GeneralStatistics({super.key});

  @override
  State<GeneralStatistics> createState() => _GeneralStatisticsState();
}

class _GeneralStatisticsState extends State<GeneralStatistics> {
  bool _isTotalDetailShown = true;

  final Map<String, IconData> tabData = {
    S.current.completion_rate: FontAwesomeIcons.chartBar,
    S.current.category_distribution: FontAwesomeIcons.tags,
    S.current.category_based_completion_rate: FontAwesomeIcons.table,
    S.current.habit_status_distribution: FontAwesomeIcons.chartPie,
  };

  List<Widget> get _getCurrentGraph => const [
        _CompletionBarChart(),
        _CategoryDistributionChart(),
        _CategoryBasedRate(),
        _GeneralPieChart(),
      ];

  static const _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabData.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Bounce(
            onPressed: () =>
                setState(() => _isTotalDetailShown = !_isTotalDetailShown),
            duration: AppCommons.buttonBounceDuration,
            child: StatisticItem(
              title: S.current.total_habit,
              subTitle: S.current.habits(10),
              icon: FontAwesomeIcons.listCheck,
              iconColor: Colors.blue,
            ),
          ),
          AnimatedSwitcherPlus.translationLeft(
            duration: const Duration(milliseconds: 500),
            child: _isTotalDetailShown
                ? _buildSpecificTotalHabit()
                : const SizedBox.shrink(),
          ),
          StatisticItem(
            title: S.current.completion_rate,
            subTitle: '76%',
            figure: S.current.change_from_last_week('positive', 5),
            figureColor: AppColors.success,
            icon: FontAwesomeIcons.chartLine,
            iconColor: AppColors.success,
          ),
          StatisticItem(
            title: S.current.longest_streak,
            subTitle: S.current.total_streak(21),
            icon: FontAwesomeIcons.fire,
            iconColor: Colors.red,
          ),
          StatisticItem(
            title: S.current.trend_section,
            subTitle: '-12%',
            figure: S.current.last_n_day(0),
            subTitleColor: Colors.red,
            icon: FontAwesomeIcons.arrowUp,
            iconColor: Colors.blueAccent,
          ),
          StatisticItem(
            title: S.current.achievement_done,
            subTitle: S.current.total_achievement(10),
            icon: FontAwesomeIcons.crown,
            iconColor: Colors.amber,
          ),
          _spacing,
          ChartTabBar(
            tabData: tabData,
            contentWidgets: _getCurrentGraph,
            defaultHeightRatio: .55,
            heightRatios: const {
              1: 0.7,
            },
          )
        ],
      ),
    );
  }

  Widget _buildSpecificTotalHabit() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      child: Column(
        children: [
          StatisticItem(
            title: S.current.active_habit,
            subTitle: '3',
            icon: Icons.circle,
            iconColor: Colors.green,
          ),
          StatisticItem(
            title: S.current.paused_habit,
            subTitle: '3',
            icon: Icons.circle,
            iconColor: Colors.amber,
          ),
          StatisticItem(
            title: S.current.failed_habit,
            subTitle: '3',
            icon: Icons.circle,
            iconColor: Colors.red,
          ),
          StatisticItem(
            title: S.current.achieved_habit,
            subTitle: '0',
            icon: Icons.check_circle,
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _GeneralPieChart extends StatelessWidget {
  const _GeneralPieChart();

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.habit_status_distribution,
      chart: HabitGeneralPieChart(
        isAlwaysShowTitle: true,
        dataItems: [
          PieChartDataItem(
            color: AppColors.success,
            value: 40,
            label: S.current.achieved_habit,
          ),
          PieChartDataItem(
            color: AppColors.error,
            value: 30,
            label: S.current.failed_habit,
          ),
          PieChartDataItem(
            color: AppColors.warning,
            value: 20,
            label: S.current.paused_habit,
          ),
          PieChartDataItem(
            color: AppColors.primary,
            value: 10,
            label: S.current.in_progress_habit,
          ),
        ],
      ),
    );
  }
}

class _CategoryBasedRate extends StatelessWidget {
  const _CategoryBasedRate();

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.category_distribution,
      chart: CategoryDistributionChart(
        categories: HabitCategory.values
            .map((category) => category.categoryName)
            .toList(),
      ),
    );
  }
}

class _CompletionBarChart extends StatelessWidget {
  const _CompletionBarChart();

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.completion_rate,
      spacing: AppSpacing.marginXL,
      chart: const CompletionBarchart(allHabitHistories: []),
    );
  }
}

class _CategoryDistributionChart extends StatelessWidget {
  const _CategoryDistributionChart();

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.category_distribution,
      spacing: 0,
      chart: HabitGeneralPieChart(
        dataItems: HabitCategory.values
            .map(
              (category) => PieChartDataItem(
                color: category.color,
                value: Random().nextInt(100).toDouble(),
                label: category.name.toUpperCase(),
                subData: category.name,
              ),
            )
            .toList(),
      ),
    );
  }
}
