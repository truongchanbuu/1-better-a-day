import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../generated/l10n.dart';
import 'charts/default_status_tab_bar_chart.dart';
import 'statistic_item.dart';

class FailedStatistic extends StatelessWidget {
  const FailedStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticItem(
          title: S.current.failed_statistic_page,
          subTitle: '10',
          iconColor: AppColors.error,
          icon: FontAwesomeIcons.ban,
        ),
        StatisticItem(
          title: S.current.failed_rate,
          subTitle: '76%',
          subTitleColor: AppColors.error,
          iconColor: Colors.amber,
          icon: FontAwesomeIcons.faceSadCry,
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
          primaryBarColor: AppColors.error,
          primaryColorTitle: S.current.failure_title,
        ),
      ],
    );
  }
}
