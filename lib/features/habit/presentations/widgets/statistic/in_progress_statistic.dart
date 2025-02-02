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

class InProgressStatistic extends StatefulWidget {
  const InProgressStatistic({super.key});

  @override
  State<InProgressStatistic> createState() => _InProgressStatisticState();
}

class _InProgressStatisticState extends State<InProgressStatistic> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticCrudBloc>().add(LoadActiveStatistic());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCrudBloc, StatisticCrudState>(
      buildWhen: (previous, current) =>
          current is ActiveStatisticLoaded || current is StatisticLoading,
      builder: (context, state) {
        if (state is StatisticLoading) {
          return LoadingIndicator(indicatorType: Indicator.pacman);
        }

        if (state is! ActiveStatisticLoaded) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticItem(
              title: S.current.active_habit,
              subTitle: state.activeHabits.toStringAsFixedWithoutZero(),
              figureColor: AppColors.primary,
              iconColor: AppColors.primary,
              icon: FontAwesomeIcons.play,
            ),
            const SizedBox(height: AppSpacing.marginM),
            // Graphs
            DefaultStatusTabBarChart(
              primaryBarColor: AppColors.primary,
              primaryColorTitle: S.current.in_progress_habit,
              toolTipTitle: S.current.in_progress_title,
              habitData: state.habitData,
            ),
          ],
        );
      },
    );
  }
}
