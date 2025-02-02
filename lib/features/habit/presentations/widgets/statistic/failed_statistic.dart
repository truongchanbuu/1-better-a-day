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

class FailedStatistic extends StatefulWidget {
  const FailedStatistic({super.key});

  @override
  State<FailedStatistic> createState() => _FailedStatisticState();
}

class _FailedStatisticState extends State<FailedStatistic> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticCrudBloc>().add(LoadFailedStatistic());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCrudBloc, StatisticCrudState>(
      buildWhen: (previous, current) =>
          current is StatisticLoading || current is FailedStatisticLoaded,
      builder: (context, state) {
        if (state is StatisticLoading) {
          return LoadingIndicator(indicatorType: Indicator.pacman);
        }

        if (state is! FailedStatisticLoaded) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticItem(
              title: S.current.failed_statistic_page,
              subTitle: state.failedHabits.toStringAsFixedWithoutZero(),
              iconColor: AppColors.error,
              icon: FontAwesomeIcons.ban,
            ),
            StatisticItem(
              title: S.current.failed_rate,
              subTitle: state.overallFailedRate.toStringAsFixedWithoutZero(),
              subTitleColor: AppColors.error,
              iconColor: Colors.amber,
              icon: _getIconByFailedRate(state.overallFailedRate),
            ),
            const SizedBox(height: AppSpacing.marginM),
            // Graphs
            DefaultStatusTabBarChart(
              primaryBarColor: AppColors.error,
              primaryColorTitle: S.current.failure_title,
              toolTipTitle: S.current.failed_title,
              habitData: state.habitData,
            ),
          ],
        );
      },
    );
  }

  IconData _getIconByFailedRate(double overallFailedRate) {
    if (overallFailedRate >= 0.5) {
      return FontAwesomeIcons.faceSadCry;
    } else if (overallFailedRate >= 0.3) {
      return FontAwesomeIcons.faceSadTear;
    } else if (overallFailedRate >= 0.2) {
      return FontAwesomeIcons.faceDizzy;
    } else if (overallFailedRate >= 0.1) {
      return FontAwesomeIcons.faceSmile;
    } else {
      return FontAwesomeIcons.faceGrinStars;
    }
  }
}
