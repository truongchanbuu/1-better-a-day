import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/num_extension.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../generated/l10n.dart';
import 'chart_color_note.dart';

class CategoryBasedCompletionRateBar extends StatelessWidget {
  final Map<String, List<double>> habitData;
  final Color primaryColor;
  final Color secondaryColor;
  final String primaryColorTitle;
  final String tooltipTitle;

  const CategoryBasedCompletionRateBar({
    super.key,
    required this.habitData,
    this.primaryColor = AppColors.success,
    this.secondaryColor = AppColors.grayText,
    required this.primaryColorTitle,
    required this.tooltipTitle,
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
          ColorNoteItem(
            color: primaryColor,
            title: primaryColorTitle,
          ),
          ColorNoteItem(
            color: secondaryColor,
            title: S.current.same_type_habit,
          ),
        ]),
      ],
    );
  }

  static const double _barWidth = 10;
  static const BorderRadius _borderRadius = BorderRadius.all(Radius.zero);
  List<BarChartGroupData> _buildBarGroups() {
    return habitData.entries.map(
      (entry) {
        String category = entry.key;
        int index = habitData.keys.toList().indexOf(category);
        final [total, data] = entry.value;

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: data,
              color: primaryColor,
              width: _barWidth,
              borderRadius: _borderRadius,
            ),
            BarChartRodData(
              toY: total,
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

  BarTooltipItem? _buildToolTipItem(
    BarChartGroupData group,
    int groupIndex,
    BarChartRodData rod,
    int rodIndex,
  ) {
    String category = habitData.keys.toList()[groupIndex];
    final [total, data] = habitData[category]!;

    return BarTooltipItem(
      category.toUpperCaseFirstLetter,
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
              text: '$tooltipTitle ${data.toStringAsFixedWithoutZero()}',
            ),
            const TextSpan(text: '\n'),
            TextSpan(text: S.current.total(total.toInt())),
          ],
        )
      ],
    );
  }
}
