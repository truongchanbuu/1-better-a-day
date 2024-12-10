import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit_category.dart';
import '../../../../../generated/l10n.dart';
import 'charts/category_distribution_chart.dart';
import 'charts/completion_bar_chart.dart';
import 'charts/habit_general_pie_chart.dart';
import 'statistic_item.dart';

class GeneralStatistics extends StatefulWidget {
  const GeneralStatistics({super.key});

  @override
  State<GeneralStatistics> createState() => _GeneralStatisticsState();
}

class _GeneralStatisticsState extends State<GeneralStatistics>
    with TickerProviderStateMixin {
  late final TabController _tabBarController;

  bool _isTotalDetailShown = true;

  final Map<String, IconData> tabData = {
    S.current.completion_rate: FontAwesomeIcons.chartBar,
    S.current.category_distribution: FontAwesomeIcons.table,
    S.current.habit_status_distribution: FontAwesomeIcons.chartPie,
  };

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: tabData.length, vsync: this);
  }

  double get _getSuitableHeight => switch (_tabBarController.index) {
        0 => MediaQuery.of(context).size.height * 0.3,
        1 => MediaQuery.of(context).size.height * 0.45,
        2 => MediaQuery.of(context).size.height * 0.45,
        _ => MediaQuery.of(context).size.height * 0.45,
      };

  List<Widget> get _getCurrentGraph => const [
        _CompletionBarChart(),
        _CategoryDistribution(),
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
            figureColor: Colors.green,
            icon: FontAwesomeIcons.chartLine,
            iconColor: Colors.green,
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

          // Completion Rate Chart
          ButtonsTabBar(
            controller: _tabBarController,
            tabs: tabData.entries.map(_buildTabWidget).toList(),
            labelSpacing: AppSpacing.paddingMS,
            contentCenter: true,
            contentPadding: const EdgeInsets.all(AppSpacing.paddingS),
            backgroundColor: AppColors.primary,
            unselectedBackgroundColor: AppColors.grayBackgroundColor,
            onTap: (index) => setState(
              () {
                _tabBarController.index = index;
              },
            ),
          ),
          _spacing,
          SizedBox(
            height: _getSuitableHeight,
            child: _getCurrentGraph.elementAt(_tabBarController.index),
          ),
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

  Widget _buildTabWidget(MapEntry<String, IconData> data) {
    return Tab(
      key: ValueKey(data.key),
      text: data.key,
      icon: Icon(data.value),
    );
  }
}

class _GeneralPieChart extends StatelessWidget {
  const _GeneralPieChart();

  @override
  Widget build(BuildContext context) {
    return _ChartSection(
      title: S.current.habit_status_distribution,
      chart: const HabitGeneralPieChart(),
    );
  }
}

class _CategoryDistribution extends StatelessWidget {
  const _CategoryDistribution();

  @override
  Widget build(BuildContext context) {
    return _ChartSection(
      title: S.current.category_distribution,
      chart: CategoryDistributionChart(
        categories:
            HabitCategory.values.map((category) => category.name).toList(),
      ),
    );
  }
}

class _CompletionBarChart extends StatelessWidget {
  const _CompletionBarChart();

  @override
  Widget build(BuildContext context) {
    return _ChartSection(
      title: S.current.completion_rate,
      spacing: AppSpacing.marginXL,
      chart: const CompletionBarchart(allHabitHistories: []),
    );
  }
}

class _ChartSection extends StatelessWidget {
  const _ChartSection({
    required this.title,
    required this.chart,
    this.spacing = AppSpacing.marginL,
  });

  final String title;
  final Widget chart;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        SizedBox(height: spacing),
        chart,
      ],
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
        fontSize: AppFontSize.h2,
      ),
    );
  }
}
