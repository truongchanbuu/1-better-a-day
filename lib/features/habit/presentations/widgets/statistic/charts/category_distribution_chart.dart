import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_common.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/num_extension.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../generated/l10n.dart';
import 'chart_color_note.dart';

class CategoryDistributionChart extends StatelessWidget {
  final Map<String, List<double>> habitData;
  const CategoryDistributionChart({super.key, required this.habitData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.4,
          child: BarChart(
            duration: AppCommons.chartDuration,
            BarChartData(
              barGroups: _buildBarGroups(),
              titlesData: _buildTitlesData(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: _buildToolTipItem,
                  getTooltipColor: (group) => AppColors.graphTooltipColor,
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.marginL),
        ChartColorNote(items: [
          ColorNoteItem(
            color: AppColors.success,
            title: S.current.achieved_habit,
          ),
          ColorNoteItem(color: AppColors.error, title: S.current.failed_habit),
          ColorNoteItem(
            color: AppColors.warning,
            title: S.current.paused_habit,
          ),
          ColorNoteItem(
            color: AppColors.primary,
            title: S.current.in_progress_habit,
          ),
        ]),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return habitData.entries.map((entry) {
      String category = entry.key;
      int index = habitData.keys.toList().indexOf(category);
      final [total, achieved, failed, paused, inProgress] = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            rodStackItems: [
              BarChartRodStackItem(0, achieved, AppColors.success),
              BarChartRodStackItem(
                achieved,
                achieved + failed,
                AppColors.error,
              ),
              BarChartRodStackItem(
                achieved + failed,
                achieved + failed + paused,
                AppColors.warning,
              ),
            ],
            toY: total,
            width: 20,
            color: AppColors.primary,
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
        groupVertically: true,
      );
    }).toList();
  }

  FlTitlesData _buildTitlesData() {
    return const FlTitlesData(
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        drawBelowEverything: true,
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
        ),
      ),
    );
  }

  static const _toolTipTextStyle = TextStyle(
    overflow: TextOverflow.ellipsis,
  );
  BarTooltipItem? _buildToolTipItem(
    BarChartGroupData group,
    int groupIndex,
    BarChartRodData rod,
    int rodIndex,
  ) {
    String category = habitData.keys.toList()[groupIndex];
    final [total, achieved, failed, paused, inProgress] = habitData[category]!;
    // final inProgress = total - (achieved + failed + paused);

    return BarTooltipItem(
      '${category.toUpperCaseFirstLetter}: ${total.toStringAsFixedWithoutZero(0)}',
      const TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        const TextSpan(text: '\n'),
        TextSpan(
            text: S.current.achieved(achieved.toInt()),
            style: _toolTipTextStyle),
        const TextSpan(text: '\n'),
        TextSpan(
            text: S.current.failed(failed.toInt()), style: _toolTipTextStyle),
        const TextSpan(text: '\n'),
        TextSpan(
            text: S.current.paused(paused.toInt()), style: _toolTipTextStyle),
        const TextSpan(text: '\n'),
        TextSpan(
            text: S.current.in_progress(inProgress.toInt()),
            style: _toolTipTextStyle),
      ],
    );
  }

  List<double> getHabitFigures() {
    final total = Random().nextInt(100).toDouble();
    final achieved = total * 0.3;
    final failed = total * 0.3;
    final paused = total * 0.3;

    return [total, achieved, failed, paused];
  }
}
