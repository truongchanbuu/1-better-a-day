import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_common.dart';
import '../../../../../../core/constants/app_font_size.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/num_extension.dart';
import '../../../../../../generated/l10n.dart';
import 'chart_color_note.dart';

class HabitGeneralPieChart extends StatefulWidget {
  final List<PieChartDataItem> dataItems;
  final Duration animationDuration;
  final bool? isAlwaysShowTitle;

  const HabitGeneralPieChart({
    super.key,
    required this.dataItems,
    this.animationDuration = AppCommons.chartDuration,
    this.isAlwaysShowTitle,
  });

  @override
  State<HabitGeneralPieChart> createState() => _HabitGeneralPieChartState();
}

class _HabitGeneralPieChartState extends State<HabitGeneralPieChart> {
  late bool _showAllFigure;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _showAllFigure = widget.isAlwaysShowTitle ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.current.show_all_figure_button),
            Checkbox(
              value: _showAllFigure,
              onChanged: (value) =>
                  setState(() => _showAllFigure = value ?? false),
            )
          ],
        ),
        const SizedBox(height: AppSpacing.marginL),
        AspectRatio(
          aspectRatio: 2,
          child: PieChart(
            duration: widget.animationDuration,
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sections: _generateSections(),
              titleSunbeamLayout: true,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.marginXL),
        ChartColorNote(
          items: widget.dataItems
              .map(
                (item) => ColorNoteItem(color: item.color, title: item.label),
              )
              .toList(),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generateSections() {
    return widget.dataItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched ? 130.0 : 110.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        showTitle: _showAllFigure ? _showAllFigure : isTouched,
        color: item.color,
        value: item.value,
        title: '${item.value.toStringAsFixedWithoutZero(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.lightText,
          shadows: shadows,
        ),
        badgeWidget: item.subData != null
            ? isTouched
                ? _Badge(data: item.subData!)
                : null
            : null,
        titlePositionPercentageOffset: .63,
        badgePositionPercentageOffset: 1.4,
      );
    }).toList();
  }
}

class _Badge extends StatelessWidget {
  final String data;
  const _Badge({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grayBackgroundColor,
              blurRadius: 3,
            )
          ]),
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      child: Text(
        data,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.labelLarge,
        ),
        maxLines: 4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PieChartDataItem {
  final Color color;
  final double value;
  final String label;
  final String? subData;

  const PieChartDataItem({
    required this.color,
    required this.value,
    required this.label,
    this.subData,
  });
}
