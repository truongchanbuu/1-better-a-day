import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../blocs/statistic_crud/statistic_crud_bloc.dart';
import 'charts/default_status_tab_bar_chart.dart';
import 'statistic_item.dart';

class PausedStatistic extends StatefulWidget {
  const PausedStatistic({super.key});

  @override
  State<PausedStatistic> createState() => _PausedStatisticState();
}

class _PausedStatisticState extends State<PausedStatistic> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticCrudBloc>().add(LoadPauseStatistic());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCrudBloc, StatisticCrudState>(
      buildWhen: (previous, current) =>
          current is StatisticLoading || current is PausedStatisticLoaded,
      builder: (context, state) {
        if (state is StatisticLoading) {
          return LoadingIndicator(indicatorType: Indicator.pacman);
        }

        if (state is! PausedStatisticLoaded) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticItem(
              title: S.current.paused_habit,
              subTitle: state.pausedHabits.toStringAsFixedWithoutZero(),
              figureColor: Colors.amber,
              iconColor: Colors.amber,
              icon: FontAwesomeIcons.pause,
            ),
            // StatisticItem(
            //   title: S.current.total_paused_time,
            //   subTitle: '10h',
            //   figureColor: Colors.blue,
            //   iconColor: Colors.blue,
            //   icon: FontAwesomeIcons.clock,
            // ),
            // StatisticItem(
            //   title: S.current.most_reason,
            //   subTitle: S.current.habit_failure_reason_lack_of_motivation,
            //   subTitleColor: Colors.blueGrey,
            //   iconColor: AppColors.error,
            //   icon: FontAwesomeIcons.exclamation,
            // ),
            const SizedBox(height: AppSpacing.marginM),

            // Graphs
            DefaultStatusTabBarChart(
              primaryBarColor: AppColors.warning,
              primaryColorTitle: S.current.paused_habit,
              habitData: state.habitData,
              toolTipTitle: S.current.paused_title,
            ),
          ],
        );
      },
    );
  }
}
