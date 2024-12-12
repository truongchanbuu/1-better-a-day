import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_common.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/num_extension.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../domain/entities/habit_history.dart';

class CompletionBarchart extends StatefulWidget {
  final List<HabitHistory> allHabitHistories;
  const CompletionBarchart({super.key, required this.allHabitHistories});

  @override
  State<CompletionBarchart> createState() => _CompletionBarchartState();
}

class _CompletionBarchartState extends State<CompletionBarchart> {
  static const _itemPerPage = 10;
  int _currentPage = 0;

  static const double _axisNumberSize = 35;
  static final samples = [
    'Reading Book',
    'Swimming',
    'Jogging',
    'Jogging 12',
    'Jogging 1',
    'Jogging 2',
    'Jogging 3',
    'Do Exercising',
    'Drinking Water',
    'Making breakfast',
    'Making breakfast 2',
    'Making breakfast 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: BarChart(
            duration: AppCommons.chartDuration,
            BarChartData(
              barGroups: _getAllHabitsCompletionRate(),
              minY: 0,
              maxY: 100,
              titlesData: FlTitlesData(
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  axisNameWidget: Text(S.current.completion_rate),
                  sideTitles: const SideTitles(
                    showTitles: true,
                    reservedSize: _axisNumberSize,
                  ),
                  drawBelowEverything: true,
                ),
                bottomTitles: AxisTitles(
                  sideTitles: const SideTitles(showTitles: false),
                  drawBelowEverything: true,
                  axisNameSize: 20,
                  axisNameWidget: Text(S.current.habit_name),
                ),
              ),
              barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                getTooltipColor: (group) => AppColors.graphTooltipColor,
                getTooltipItem: _buildToolTipItem,
              )),
            ),
          ),
        ),
        if (hasNextPage || _currentPage > 0) ...[
          const SizedBox(height: AppSpacing.marginM),
          ElevatedButton(
            onPressed: _currentPage > 0 ? _previousPage : _nextPage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_currentPage > 0) ...[
                  const Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: AppColors.lightText,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.marginS),
                ],
                Text(
                  _currentPage > 0
                      ? S.current.previous_habits_button
                      : S.current.next_habits_button,
                  style: const TextStyle(color: AppColors.lightText),
                ),
                if (hasNextPage) ...[
                  const SizedBox(width: AppSpacing.marginS),
                  const Icon(
                    FontAwesomeIcons.chevronRight,
                    color: AppColors.lightText,
                    size: 20,
                  ),
                ]
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage--;
    });
  }

  BarTooltipItem _buildToolTipItem(
      BarChartGroupData group, groupIndex, BarChartRodData rod, rodIndex) {
    return BarTooltipItem(
      currentPageHabits[groupIndex],
      const TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        const TextSpan(text: '\n'),
        TextSpan(
          children: [
            TextSpan(text: (rod.toY as num).toStringAsFixedWithoutZero()),
          ],
        )
      ],
    );
  }

  List<BarChartGroupData> _getAllHabitsCompletionRate() {
    return currentPageHabits
        .asMap()
        .entries
        .map((e) => BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  width: 20,
                  borderRadius: BorderRadius.zero,
                  toY: Random().nextInt(100).toDouble(),
                  color: AppColors.primary,
                ),
              ],
            ))
        .toList();
  }

  List<String> get currentPageHabits {
    final startIndex = _currentPage * _itemPerPage;
    return samples.sublist(
        startIndex, min(startIndex + _itemPerPage, samples.length));
  }

  bool get hasNextPage => (_currentPage + 1) * _itemPerPage < samples.length;
}
