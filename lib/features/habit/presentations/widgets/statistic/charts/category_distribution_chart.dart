import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_common.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../generated/l10n.dart';
import 'chart_color_note.dart';

class CategoryDistributionChart extends StatelessWidget {
  final List<String> categories;
  const CategoryDistributionChart({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: BarChart(
            duration: AppCommons.chartDuration,
            BarChartData(
              barGroups: _buildBarGroups(),
              titlesData: _buildTilesData(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: _buildToolTipItem,
                  getTooltipColor: (group) => Colors.indigo,
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.marginL),
        const ChartColorNote(),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return categories.asMap().entries.map((data) {
      int index = data.key;

      final [total, achieved, failed, paused] = getHabitFigures();

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            rodStackItems: [
              BarChartRodStackItem(0, achieved, AppColors.success),
              BarChartRodStackItem(
                  achieved, achieved + failed, AppColors.error),
              BarChartRodStackItem(failed, failed + paused, AppColors.warning),
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

  FlTitlesData _buildTilesData() {
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
  BarTooltipItem? _buildToolTipItem(BarChartGroupData group, int groupIndex,
      BarChartRodData rod, int rodIndex) {
    final [total, achieved, failed, paused] = getHabitFigures();
    final inProgress = total - (achieved + failed + paused);

    return BarTooltipItem(
      '${categories[groupIndex].toUpperCaseFirstLetter}: ${total.toStringAsFixed(0)}',
      const TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        const TextSpan(text: '\n'),
        TextSpan(
          children: [
            TextSpan(
              text: S.current.achieved(achieved.toInt()),
              style: _toolTipTextStyle,
            ),
            const TextSpan(text: '\n'),
            TextSpan(
              text: S.current.failed(failed.toInt()),
              style: _toolTipTextStyle,
            ),
            const TextSpan(text: '\n'),
            TextSpan(
              text: S.current.paused(paused.toInt()),
              style: _toolTipTextStyle,
            ),
            const TextSpan(text: '\n'),
            TextSpan(
              text: S.current.in_progress(inProgress.toInt()),
              style: _toolTipTextStyle,
            ),
          ],
        )
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
