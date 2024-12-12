import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../generated/l10n.dart';
import 'charts/default_status_tab_bar_chart.dart';
import 'statistic_item.dart';

class InProgressStatistic extends StatelessWidget {
  const InProgressStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticItem(
          title: S.current.paused_habit,
          subTitle: '10',
          figureColor: Colors.amber,
          iconColor: Colors.amber,
          icon: FontAwesomeIcons.pause,
        ),
        StatisticItem(
          title: S.current.active_habit,
          subTitle: '10h',
          iconColor: Colors.green,
          icon: FontAwesomeIcons.circle,
        ),
        const SizedBox(height: AppSpacing.marginM),

        // Graphs
        DefaultStatusTabBarChart(
          primaryBarColor: AppColors.primary,
          primaryColorTitle: S.current.in_progress_habit,
        ),
      ],
    );
  }
}
