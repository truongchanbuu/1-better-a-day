import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HabitPerformanceLineChart extends StatelessWidget {
  const HabitPerformanceLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(minY: 0, lineBarsData: [
          LineChartBarData(),
        ]),
      ),
    );
  }
}
