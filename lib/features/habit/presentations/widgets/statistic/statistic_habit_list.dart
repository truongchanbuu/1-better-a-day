import 'package:flutter/material.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../../domain/entities/habit_entity.dart';

class StatisticHabitList extends StatelessWidget {
  final List<HabitEntity> habits;

  const StatisticHabitList({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          habits.map((habit) => _StatisticHabitItem(habit: habit)).toList(),
    );
  }
}

class _StatisticHabitItem extends StatelessWidget {
  final HabitEntity habit;
  const _StatisticHabitItem({required this.habit});

  static const TextStyle _progressTextStyle = TextStyle(
    fontSize: AppFontSize.labelLarge,
    color: AppColors.grayText,
  );

  @override
  Widget build(BuildContext context) {
    final HabitStatus habitStatus = habit.habitStatus;

    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        boxShadow: const [
          BoxShadow(
            color: AppColors.grayBackgroundColor,
            blurRadius: 5,
          )
        ],
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              habitStatus.habitStatusIcon,
              color: habitStatus.habitStatusColor,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.habitTitle,
                  style: const TextStyle(
                    fontSize: AppFontSize.bodyLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextWithCircleBorderContainer(
                  title: habitStatus.statusName.toUpperCaseFirstLetter,
                  backgroundColor: habitStatus.habitStatusColor,
                  fontSize: AppFontSize.labelLarge,
                )
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.overall_progress(10, 21, S.current.day_title),
                  style: _progressTextStyle,
                ),
                Text(
                  '${S.current.achieved(100)}%',
                  style: _progressTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.marginS),
          Text(
            S.current.total_streak(20),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.bodyLarge,
              fontStyle: FontStyle.italic,
              color: AppColors.success,
            ),
          ),
          Text('${S.current.start_date}: ${DateTimeHelper.formatFullDate(
            habit.startDate,
            locale: context.locale.languageCode,
          )}'),
          Text('${S.current.end_date}: ${DateTimeHelper.formatFullDate(
            habit.endDate,
            locale: context.locale.languageCode,
          )}'),
        ],
      ),
    );
  }
}
