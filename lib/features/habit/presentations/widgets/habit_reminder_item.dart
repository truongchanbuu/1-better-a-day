import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_frequency.dart';

class HabitReminderItem extends StatelessWidget {
  final Set<String> reminderTimes;
  final HabitFrequency frequency;

  const HabitReminderItem({
    super.key,
    required this.reminderTimes,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.marginL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.repeat, size: 20),
                const SizedBox(width: AppSpacing.marginS),
                Expanded(
                  child: Text(
                    frequency.getDisplayText(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Switch.adaptive(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            if (reminderTimes.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.marginS),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 20),
                  const SizedBox(width: AppSpacing.marginS),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: reminderTimes
                          .map((time) => Chip(
                                label: Text(time),
                                backgroundColor: context.isDarkMode
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                                labelStyle: TextStyle(
                                  color: !context.isDarkMode
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
            if (frequency.lastCompletionTime != null) ...[
              const SizedBox(height: AppSpacing.marginM),
              Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 20),
                  const SizedBox(width: AppSpacing.marginS),
                  Expanded(
                    child: Text(
                      S.current.last_completed_at(
                        frequency.lastCompletionTime!
                            .toMoment()
                            .formatDateTimeShort(),
                      ),
                      style: const TextStyle(fontSize: AppFontSize.h4),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
