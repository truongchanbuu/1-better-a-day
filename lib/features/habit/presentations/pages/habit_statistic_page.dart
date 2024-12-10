import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../widgets/statistic/general_statistic.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grayBackgroundColor,
        appBar: AppBar(title: Text(S.current.statistic_section)),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(AppSpacing.paddingM),
            child: Column(
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
                const SizedBox(height: AppSpacing.marginS),
                _buildStatistics(),
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
      default:
        return Container();
    }
  }
}
