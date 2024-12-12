import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/enums/habit_category.dart';
import '../../../../../../generated/l10n.dart';
import '../../../pages/habit_statistic_page.dart';
import 'category_based_completion_rate_bar.dart';
import 'chart_tab_bar.dart';

class DefaultStatusTabBarChart extends StatelessWidget {
  final Map<String, IconData>? tabData;
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
  });

  static final Map<String, IconData> defaultTabData = {
    S.current.category_based_completion_rate: FontAwesomeIcons.chartBar,
  };

  List<Widget> get _getCurrentGraph => [
        _CategoryBasedCompletionRateBar(
          primaryColorTitle: primaryColorTitle,
          primaryBarColor: primaryBarColor,
          secondaryBarColor: secondaryBarColor,
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
  final String primaryColorTitle;
  final Color primaryBarColor;
  final Color secondaryBarColor;

  const _CategoryBasedCompletionRateBar({
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
        categories: HabitCategory.values.map((e) => e.name).toList(),
      ),
    );
  }
}
