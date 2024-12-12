import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../generated/l10n.dart';
import 'charts/default_status_tab_bar_chart.dart';
import 'statistic_item.dart';

class PausedStatistic extends StatelessWidget {
  const PausedStatistic({super.key});

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
          title: S.current.total_paused_time,
          subTitle: '10h',
          figureColor: Colors.blue,
          iconColor: Colors.blue,
          icon: FontAwesomeIcons.clock,
        ),
        StatisticItem(
          title: S.current.most_reason,
          subTitle: S.current.habit_failure_reason_lack_of_motivation,
          subTitleColor: Colors.blueGrey,
          iconColor: AppColors.error,
          icon: FontAwesomeIcons.exclamation,
        ),
        const SizedBox(height: AppSpacing.marginM),

        // Graphs
        DefaultStatusTabBarChart(
          primaryBarColor: AppColors.warning,
          primaryColorTitle: S.current.paused_habit,
        ),
      ],
    );
  }
}
