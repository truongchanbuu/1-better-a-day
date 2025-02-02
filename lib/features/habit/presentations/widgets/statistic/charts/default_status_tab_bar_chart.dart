import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../shared/domain/entities/tab_bar_item.dart';
import '../../../pages/habit_statistic_page.dart';
import 'category_based_completion_rate_bar.dart';
import 'chart_tab_bar.dart';

class DefaultStatusTabBarChart extends StatelessWidget {
  final Map<String, List<double>> habitData;
  final String toolTipTitle;
  final List<TabBarItem>? tabData;
  final List<Widget>? graphs;
  final double? defaultHeightRatio;
  final Map<int, double> heightRatios;
  final Color primaryBarColor;
  final Color secondaryBarColor;
  final String primaryColorTitle;

  const DefaultStatusTabBarChart({
    super.key,
    this.tabData,
    this.graphs,
    this.defaultHeightRatio,
    this.heightRatios = const {},
    this.primaryBarColor = AppColors.primary,
    this.secondaryBarColor = AppColors.grayText,
    required this.primaryColorTitle,
    required this.habitData,
    required this.toolTipTitle,
  });

  static final List<TabBarItem> defaultTabData = [
    TabBarItem(
      title: S.current.category_based_completion_rate,
      icon: FontAwesomeIcons.chartBar,
    ),
  ];

  List<Widget> get _getCurrentGraph => [
        _CategoryBasedCompletionRateBar(
          primaryColorTitle: primaryColorTitle,
          primaryBarColor: primaryBarColor,
          secondaryBarColor: secondaryBarColor,
          habitData: habitData,
          toolTipTitle: toolTipTitle,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return ChartTabBar(
      tabData: tabData ?? defaultTabData,
      contentWidgets: graphs ?? _getCurrentGraph,
      defaultHeightRatio: defaultHeightRatio ?? .5,
      heightRatios: heightRatios,
    );
  }
}

class _CategoryBasedCompletionRateBar extends StatelessWidget {
  final Map<String, List<double>> habitData;
  final String toolTipTitle;
  final String primaryColorTitle;
  final Color primaryBarColor;
  final Color secondaryBarColor;

  const _CategoryBasedCompletionRateBar({
    required this.habitData,
    required this.toolTipTitle,
    required this.primaryColorTitle,
    required this.primaryBarColor,
    required this.secondaryBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChartSection(
      title: S.current.category_based_completion_rate,
      chart: CategoryBasedCompletionRateBar(
        primaryColorTitle: primaryColorTitle,
        primaryColor: primaryBarColor,
        secondaryColor: secondaryBarColor,
        habitData: habitData,
        tooltipTitle: toolTipTitle,
      ),
    );
  }
}
