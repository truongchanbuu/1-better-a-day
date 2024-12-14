import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../widgets/statistic/achieved_statistic.dart';
import '../widgets/statistic/current_statistic.dart';
import '../widgets/statistic/failed_statistic.dart';
import '../widgets/statistic/general_statistic.dart';
import '../widgets/statistic/in_progress_statistic.dart';
import '../widgets/statistic/paused_statistic.dart';
import '../widgets/statistic/statistic_habit_list.dart';
import 'habit_detail_page.dart';

class HabitStatisticPage extends StatefulWidget {
  const HabitStatisticPage({super.key});

  @override
  State<HabitStatisticPage> createState() => _HabitStatisticPageState();
}

class _HabitStatisticPageState extends State<HabitStatisticPage> {
  static const allPageKey = 'allPage';
  static const activePageKey = 'activePage';
  static const pausePageKey = 'pausePage';
  static const failedPageKey = 'failedPage';
  static const achievedPageKey = 'achievedPage';
  Map<String, String> pageNames = {
    allPageKey: S.current.all_statistic_page,
    activePageKey: S.current.active_statistic_page,
    pausePageKey: S.current.pause_statistic_page,
    failedPageKey: S.current.failed_statistic_page,
    achievedPageKey: S.current.achieved_statistic_page,
  };

  String? _selectedPageKey;

  @override
  void initState() {
    super.initState();
    _selectedPageKey = pageNames.keys.first;
  }

  static const _spacing = SizedBox(height: AppSpacing.marginS);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? AppColors.primaryDark
            : AppColors.grayBackgroundColor,
        appBar: AppBar(title: Text(S.current.statistic_section)),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(AppSpacing.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton2<String>(
                  hint: Text(pageNames[_selectedPageKey]!),
                  isExpanded: true,
                  selectedItemBuilder: (context) =>
                      pageNames.values.map((name) => Text(name)).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPageKey = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppSpacing.radiusS)),
                    ),
                  ),
                  items: pageNames.keys
                      .map((key) => DropdownMenuItem<String>(
                          value: key, child: Text(pageNames[key]!)))
                      .toList(),
                ),
                _spacing,
                _buildStatistics(),
                _spacing,

                // Habit List
                Text(
                  S.current.habit_detail,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.h3,
                  ),
                ),
                _spacing,
                StatisticHabitList(habits: [habit]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    switch (_selectedPageKey) {
      case allPageKey:
        return const GeneralStatistics();
      case achievedPageKey:
        return const AchievedStatistic();
      case failedPageKey:
        return const FailedStatistic();
      case pausePageKey:
        return const PausedStatistic();
      case activePageKey:
        return const InProgressStatistic();
      default:
        return const CurrentStatistic();
    }
  }
}

class ChartSection extends StatelessWidget {
  const ChartSection({
    super.key,
    required this.title,
    required this.chart,
    this.spacing = AppSpacing.marginL,
  });

  final String title;
  final Widget chart;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        SizedBox(height: spacing),
        chart,
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.h2,
      ),
    );
  }
}
