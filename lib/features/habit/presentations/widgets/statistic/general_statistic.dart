import 'dart:math';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/habit_category.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/domain/entities/tab_bar_item.dart';
import '../../../domain/entities/habit_history.dart';
import '../../blocs/statistic_crud/statistic_crud_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<StatisticCrudBloc>().add(LoadGeneralStatistic());
  }

  bool _isTotalDetailShown = true;

  final List<TabBarItem> tabData = [
    TabBarItem(
      title: S.current.completion_rate,
      icon: FontAwesomeIcons.chartBar,
    ),
    TabBarItem(
      title: S.current.category_distribution,
      icon: FontAwesomeIcons.tags,
    ),
    TabBarItem(
      title: S.current.category_based_completion_rate,
      icon: FontAwesomeIcons.table,
    ),
    TabBarItem(
      title: S.current.habit_status_distribution,
      icon: FontAwesomeIcons.chartPie,
    ),
  ];

  List<Widget> _getCurrentGraph(GeneralStatisticLoaded state) => [
        _CompletionBarChart(state.allHistories),
        const _CategoryDistributionChart(),
        const _CategoryBasedRate(),
        const _GeneralPieChart(),
      ];

  static const _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabData.length,
      child: BlocBuilder<StatisticCrudBloc, StatisticCrudState>(
        buildWhen: (previous, current) => current is GeneralStatisticLoaded,
        builder: (context, state) {
          if (state is StatisticLoading) {
            return LoadingIndicator(indicatorType: Indicator.pacman);
          }

          if (state is! GeneralStatisticLoaded) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bounce(
                onPressed: () =>
                    setState(() => _isTotalDetailShown = !_isTotalDetailShown),
                duration: AppCommons.buttonBounceDuration,
                child: StatisticItem(
                  title: S.current.total_habit,
                  subTitle: S.current.habits(state.totalHabits),
                  icon: FontAwesomeIcons.listCheck,
                  iconColor: Colors.blue,
                ),
              ),
              AnimatedSwitcherPlus.translationLeft(
                duration: const Duration(milliseconds: 500),
                child: _isTotalDetailShown
                    ? _buildSpecificTotalHabit(state)
                    : const SizedBox.shrink(),
              ),
              StatisticItem(
                title: S.current.completion_rate,
                subTitle: state.completionRate.toStringAsFixedWithoutZero(),
                figure: S.current.change_from_last_week(
                  _getCompletionRateChangeText(state.completionRateTrend),
                  state.completionRateTrend,
                ),
                figureColor: AppColors.success,
                icon: FontAwesomeIcons.chartLine,
                iconColor: AppColors.success,
              ),
              StatisticItem(
                title: S.current.longest_streak,
                subTitle: S.current.total_streak(state.longestStreak),
                icon: FontAwesomeIcons.fire,
                iconColor: Colors.red,
              ),
              StatisticItem(
                title: S.current.achievement_done,
                subTitle: S.current.total_achievement(state.totalAchievements),
                icon: FontAwesomeIcons.crown,
                iconColor: Colors.amber,
              ),
              _spacing,
              ChartTabBar(
                tabData: tabData,
                contentWidgets: _getCurrentGraph(state),
                defaultHeightRatio: .55,
                heightRatios: const {1: 0.75},
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSpecificTotalHabit(GeneralStatisticLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      child: Column(
        children: [
          StatisticItem(
            title: S.current.active_habit,
            subTitle: state.activeHabits.toStringAsFixedWithoutZero(),
            icon: Icons.circle,
            iconColor: Colors.green,
          ),
          StatisticItem(
            title: S.current.paused_habit,
            subTitle: state.pausedHabits.toStringAsFixedWithoutZero(),
            icon: Icons.circle,
            iconColor: Colors.amber,
          ),
          StatisticItem(
            title: S.current.failed_habit,
            subTitle: state.failedHabits.toStringAsFixedWithoutZero(),
            icon: Icons.circle,
            iconColor: Colors.red,
          ),
          StatisticItem(
            title: S.current.achieved_habit,
            subTitle: state.achievedHabits.toStringAsFixedWithoutZero(),
            icon: Icons.check_circle,
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }

  String _getCompletionRateChangeText(double completionRateTrend) {
    return completionRateTrend > 0
        ? 'positive'
        : completionRateTrend < 0
            ? 'negative'
            : 'neutral';
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
            .takeWhile((value) => value != HabitCategory.custom)
            .map((category) => category.categoryName)
            .toList(),
      ),
    );
  }
}

class _CompletionBarChart extends StatelessWidget {
  final List<HabitHistory> allHabitHistories;
  const _CompletionBarChart(this.allHabitHistories);

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.completion_rate,
      spacing: AppSpacing.marginXL,
      chart: CompletionBarchart(allHabitHistories: allHabitHistories),
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
            .takeWhile((value) => value != HabitCategory.custom)
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
