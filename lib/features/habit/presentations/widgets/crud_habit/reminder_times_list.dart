import 'package:flutter/material.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../generated/l10n.dart';

class ReminderTimesListSection extends StatelessWidget {
  final Set<String> reminderTimes;
  final VoidCallback? onPickReminder;
  final Function(String time)? onDeleteItem;
  final double? titleSize;

  const ReminderTimesListSection({
    super.key,
    this.reminderTimes = const {},
    this.onPickReminder,
    this.onDeleteItem,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.reminder_section,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleSize ?? AppFontSize.h4,
              ),
            ),
            if (onPickReminder != null)
              IconButton(
                onPressed: onPickReminder,
                icon: const Icon(
                  Icons.add,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
        ReminderItemList(
          reminderTimes: reminderTimes,
          onDeleteItem: onDeleteItem,
        ),
      ],
    );
  }
}

class ReminderItemList extends StatelessWidget {
  final Set<String> reminderTimes;
  final Function(String time)? onDeleteItem;
  const ReminderItemList({
    super.key,
    required this.reminderTimes,
    this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: reminderTimes
          .map((e) => ListTile(
                leading: const Icon(
                  Icons.access_time,
                  color: AppColors.primary,
                ),
                title: Text(e),
                trailing: onDeleteItem != null
                    ? GestureDetector(
                        onTap: () => onDeleteItem?.call(e),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    : null,
              ))
          .toList(),
    );
  }
}
