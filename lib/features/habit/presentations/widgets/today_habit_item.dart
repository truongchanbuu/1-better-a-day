import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_entity.dart';

class TodayHabitItem extends StatefulWidget {
  final HabitEntity habit;
  const TodayHabitItem({super.key, required this.habit});

  @override
  State<TodayHabitItem> createState() => _TodayHabitItemState();
}

class _TodayHabitItemState extends State<TodayHabitItem> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
      ),
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.marginS),
      child: ListTile(
        onTap: () {},
        leading: Icon(
          isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: isCompleted ? AppColors.success : null,
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Drinking',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h4,
              ),
            ),
            const SizedBox(height: AppSpacing.marginXS),
            Text(
              S.current.total_streak(10),
              style: const TextStyle(
                fontSize: AppFontSize.labelLarge,
                color: AppColors.grayText,
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 130,
          child: LinearPercentIndicator(
            progressColor: AppColors.primary,
            backgroundColor: AppColors.grayBackgroundColor,
            percent: 0.4,
          ),
        ),
      ),
    );
  }
}
