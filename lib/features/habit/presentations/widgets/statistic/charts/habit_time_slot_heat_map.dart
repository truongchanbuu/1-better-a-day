import 'dart:math';

import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/helpers/date_time_helper.dart';
import '../../../../../../generated/l10n.dart';

class HabitTimeSlotHeatMap extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  HabitTimeSlotHeatMap({super.key})
      : endDate = DateTime.now(),
        startDate = DateTime.now().subtract(const Duration(days: 7));

  late final List<String> cols =
      DateTimeHelper.getLocalizedDayNames(date: startDate);

  static final List<Color> colors = [
    Colors.grey[300]!,
    Colors.blue[100]!,
    Colors.blue[300]!,
    Colors.blue[500]!,
    Colors.blue[700]!,
    Colors.blue[900]!,
  ];

  static const rows = DateTimeHelper.timeSlots;
  static const _horizonSpacing = SizedBox(width: AppSpacing.marginS);
  static const _vertSpacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    final r = Random();
    return Column(
      children: [
        Heatmap(
          heatmapData: HeatmapData(
            colorPalette: colors,
            columns: cols,
            rows: rows,
            items: [
              for (int row = 0; row < rows.length; row++)
                for (int col = 0; col < cols.length; col++)
                  HeatmapItem(
                    value: r.nextDouble() * 6,
                    xAxisLabel: cols[col],
                    yAxisLabel: rows[row],
                  ),
            ],
          ),
        ),
        _vertSpacing,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.current.less_title),
            _horizonSpacing,
            ...colors.map((color) => Container(
                  color: color,
                  width: 25,
                  height: 25,
                )),
            _horizonSpacing,
            Text(S.current.more_title),
          ],
        )
      ],
    );
  }
}
