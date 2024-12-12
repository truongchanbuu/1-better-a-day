import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../generated/l10n.dart';
import 'charts/default_status_tab_bar_chart.dart';
import 'statistic_item.dart';

class AchievedStatistic extends StatelessWidget {
  const AchievedStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticItem(
          title: S.current.achieved_statistic_page,
          subTitle: '10',
          figureColor: Colors.amber,
          iconColor: Colors.amber,
          icon: FontAwesomeIcons.medal,
        ),
        StatisticItem(
          title: S.current.completion_rate,
          subTitle: '76%',
          subTitleColor: AppColors.success,
          iconColor: AppColors.success,
          icon: FontAwesomeIcons.bullseye,
        ),
        StatisticItem(
          title: S.current.avg_time,
          subTitle: '30 ngày',
          subTitleColor: Colors.purple,
          iconColor: Colors.purple,
          icon: FontAwesomeIcons.userClock,
        ),

        const SizedBox(height: AppSpacing.marginM),
        // Graphs
        DefaultStatusTabBarChart(
          primaryBarColor: AppColors.success,
          primaryColorTitle: S.current.achieved_habit,
        ),
      ],
    );
  }
}
