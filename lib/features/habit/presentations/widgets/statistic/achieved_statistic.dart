import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../blocs/statistic_crud/statistic_crud_bloc.dart';
import 'charts/default_status_tab_bar_chart.dart';
import 'statistic_item.dart';

class AchievedStatistic extends StatefulWidget {
  const AchievedStatistic({super.key});

  @override
  State<AchievedStatistic> createState() => _AchievedStatisticState();
}

class _AchievedStatisticState extends State<AchievedStatistic> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticCrudBloc>().add(LoadAchievedStatistic());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCrudBloc, StatisticCrudState>(
      buildWhen: (previous, current) =>
          current is StatisticLoading || current is AchievedStatisticLoaded,
      builder: (context, state) {
        if (state is StatisticLoading) {
          return LoadingIndicator(indicatorType: Indicator.pacman);
        }

        if (state is! AchievedStatisticLoaded) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticItem(
              title: S.current.achieved_statistic_page,
              subTitle: state.achievedHabits.toStringAsFixedWithoutZero(),
              figureColor: Colors.amber,
              iconColor: Colors.amber,
              icon: FontAwesomeIcons.medal,
            ),
            StatisticItem(
              title: S.current.avg_time,
              subTitle: DateTimeHelper.formatDuration(state.avgDuration),
              subTitleColor: Colors.purple,
              iconColor: Colors.purple,
              icon: FontAwesomeIcons.userClock,
            ),
            StatisticItem(
              title: S.current.fastest_time,
              subTitle: DateTimeHelper.formatDuration(state.fastestDuration),
              subTitleColor: Colors.indigo,
              iconColor: Colors.indigo,
              icon: FontAwesomeIcons.personRunning,
            ),
            StatisticItem(
              title: S.current.longest_time,
              subTitle: DateTimeHelper.formatDuration(state.longestDuration),
              subTitleColor: Colors.green,
              iconColor: Colors.green,
              icon: FontAwesomeIcons.personWalking,
            ),
            const SizedBox(height: AppSpacing.marginM),
            // Graphs
            DefaultStatusTabBarChart(
              primaryBarColor: AppColors.success,
              primaryColorTitle: S.current.achieved_habit,
              habitData: state.habitData,
              toolTipTitle: S.current.achieved_title,
            ),
          ],
        );
      },
    );
  }
}
