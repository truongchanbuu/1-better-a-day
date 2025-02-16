import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/habit_category.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/domain/entities/tab_bar_item.dart';
import '../../../domain/entities/habit_entity.dart';
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
        _CompletionBarChart(
          allHabitHistories: state.allHistories,
          habits: state.allHabits,
        ),
        _CategoryDistributionChart(state.allHabits),
        _CategoryBasedRate(state.allHabits),
        _GeneralPieChart(state.allHabits),
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
                title: S.current.weekly_completion_rate,
                subTitle:
                    state.weeklyCompletionRate.toStringAsFixedWithoutZero(),
                figure: S.current.change_from_last_week(
                  _getCompletionRateChangeText(state.completionRateTrend),
                  state.completionRateTrend,
                ),
                figureColor:
                    _getCompletionRateChangeColor(state.completionRateTrend),
                icon: FontAwesomeIcons.chartLine,
                iconColor: AppColors.success,
              ),
              StatisticItem(
                title: S.current.overall_completion_rate,
                subTitle:
                    state.overallCompletionRate.toStringAsFixedWithoutZero(),
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

  Color _getCompletionRateChangeColor(double completionRateTrend) {
    return completionRateTrend > 0
        ? AppColors.success
        : completionRateTrend < 0
            ? AppColors.error
            : AppColors.grayText;
  }
}

class _GeneralPieChart extends StatelessWidget {
  final List<HabitEntity> habits;
  const _GeneralPieChart(this.habits);

  Map<HabitStatus, double> get habitStatusDistribution {
    final statusCount = <HabitStatus, int>{};

    for (var status in HabitStatus.values) {
      statusCount[status] = 0;
    }

    for (var habit in habits) {
      statusCount[habit.habitStatus] =
          (statusCount[habit.habitStatus] ?? 0) + 1;
    }

    final totalHabits =
        statusCount.values.fold<int>(0, (sum, count) => sum + count);

    return statusCount.map((key, value) {
      final percentage = totalHabits > 0 ? (value / totalHabits * 100) : 0.0;

      return MapEntry(key, percentage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.habit_status_distribution,
      chart: HabitGeneralPieChart(
        isAlwaysShowTitle: true,
        dataItems: [
          PieChartDataItem(
            color: AppColors.success,
            value: habitStatusDistribution[HabitStatus.achieved] ?? 0,
            label: S.current.achieved_habit,
          ),
          PieChartDataItem(
            color: AppColors.error,
            value: habitStatusDistribution[HabitStatus.failed] ?? 0,
            label: S.current.failed_habit,
          ),
          PieChartDataItem(
            color: AppColors.warning,
            value: habitStatusDistribution[HabitStatus.paused] ?? 0,
            label: S.current.paused_habit,
          ),
          PieChartDataItem(
            color: AppColors.primary,
            value: habitStatusDistribution[HabitStatus.inProgress] ?? 0,
            label: S.current.in_progress_habit,
          ),
        ],
      ),
    );
  }
}

class _CategoryBasedRate extends StatelessWidget {
  final List<HabitEntity> habits;
  const _CategoryBasedRate(this.habits);

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.category_distribution,
      chart: CategoryDistributionChart(habitData: habitData),
    );
  }

  Map<String, List<double>> get habitData {
    final categoryData = habits.groupListsBy((habit) => habit.habitCategory);

    return Map.fromEntries(HabitCategory.valuesWithoutCustom.map((category) {
      final categoryHabits = categoryData[category] ?? [];

      double total = categoryHabits.length.toDouble();
      double achieved =
          categoryHabits.where((h) => h.isAchieved).length.toDouble();
      double failed = categoryHabits.where((h) => h.isFailed).length.toDouble();
      double paused = categoryHabits.where((h) => h.isPaused).length.toDouble();
      double inProgress = total - (achieved + failed + paused);

      return MapEntry(
        category.name,
        [total, achieved, failed, paused, inProgress],
      );
    }));
  }
}

class _CompletionBarChart extends StatelessWidget {
  final List<HabitEntity> habits;
  final List<HabitHistory> allHabitHistories;
  const _CompletionBarChart({
    required this.allHabitHistories,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.completion_rate,
      spacing: AppSpacing.marginXL,
      chart: CompletionBarchart(
        allHabitHistories: allHabitHistories,
        habits: habits,
      ),
    );
  }
}

class _CategoryDistributionChart extends StatelessWidget {
  final List<HabitEntity> habits;
  const _CategoryDistributionChart(this.habits);

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.category_distribution,
      spacing: 0,
      chart: HabitGeneralPieChart(
        dataItems: _calculateCategoryDistribution(),
      ),
    );
  }

  List<PieChartDataItem> _calculateCategoryDistribution() {
    final categoryCount = <HabitCategory, int>{};

    for (var category in HabitCategory.values) {
      if (category != HabitCategory.custom) {
        categoryCount[category] = 0;
      }
    }

    for (var habit in habits) {
      if (habit.habitCategory != HabitCategory.custom) {
        categoryCount[habit.habitCategory] =
            (categoryCount[habit.habitCategory] ?? 0) + 1;
      }
    }

    final totalHabits =
        categoryCount.values.fold<int>(0, (sum, count) => sum + count);

    return categoryCount.entries.where((entry) => entry.value > 0).map((entry) {
      final percentage =
          totalHabits > 0 ? (entry.value / totalHabits * 100) : 0.0;

      return PieChartDataItem(
        color: entry.key.color,
        value: percentage,
        label: entry.key.name.toUpperCaseFirstLetter,
        subData: S.current.habits(entry.value),
      );
    }).toList();
  }
}
