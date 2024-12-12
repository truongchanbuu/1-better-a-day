import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../generated/l10n.dart';
import 'chart_color_note.dart';

class CategoryBasedCompletionRateBar extends StatelessWidget {
  final List<String> categories;
  final Color primaryColor;
  final Color secondaryColor;
  final String primaryColorTitle;

  const CategoryBasedCompletionRateBar({
    super.key,
    required this.categories,
    this.primaryColor = AppColors.success,
    this.secondaryColor = AppColors.grayText,
    required this.primaryColorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: BarChart(
            BarChartData(
              minY: 0,
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
          ColorNoteItem(color: primaryColor, title: primaryColorTitle),
          ColorNoteItem(
              color: secondaryColor, title: S.current.same_type_habit),
        ]),
      ],
    );
  }

  static const double _barWidth = 10;
  static const BorderRadius _borderRadius = BorderRadius.all(Radius.zero);
  List<BarChartGroupData> _buildBarGroups() {
    return categories.asMap().entries.map(
      (e) {
        int index = e.key;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: Random().nextInt(100).toDouble(),
              color: primaryColor,
              width: _barWidth,
              borderRadius: _borderRadius,
            ),
            BarChartRodData(
              toY: Random().nextInt(100).toDouble(),
              color: secondaryColor,
              width: _barWidth,
              borderRadius: _borderRadius,
            ),
          ],
        );
      },
    ).toList();
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

  BarTooltipItem? _buildToolTipItem(BarChartGroupData group, int groupIndex,
      BarChartRodData rod, int rodIndex) {
    return BarTooltipItem(
      categories[groupIndex].toUpperCaseFirstLetter,
      const TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        const TextSpan(text: '\n'),
        TextSpan(
          children: [
            TextSpan(text: S.current.achieved(Random().nextInt(100))),
            const TextSpan(text: '\n'),
            TextSpan(text: S.current.total(Random().nextInt(100))),
          ],
        )
      ],
    );
  }
}
