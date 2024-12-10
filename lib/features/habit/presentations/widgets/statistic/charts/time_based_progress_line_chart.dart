import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/extensions/context_extension.dart';

class TimeBasedProgressLineChart extends StatefulWidget {
  const TimeBasedProgressLineChart({super.key});

  @override
  State<TimeBasedProgressLineChart> createState() =>
      _TimeBasedProgressLineChartState();
}

class _TimeBasedProgressLineChartState
    extends State<TimeBasedProgressLineChart> {
  List<String> mode = ['Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: mode.length,
            labels: mode,
            borderWidth: 1,
            inactiveBgColor:
                context.isDarkMode ? AppColors.darkText : AppColors.lightText,
            borderColor: const [AppColors.grayBackgroundColor],
            onToggle: (index) {},
          ),
        ),
      ],
    );
  }
}
