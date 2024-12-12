import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../domain/entities/reminder_entity.dart';

class ReminderItem extends StatelessWidget {
  final ReminderEntity reminder;
  const ReminderItem({super.key, required this.reminder});

  static const _spacing = SizedBox(height: AppSpacing.marginS);
  static const double _iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SwipeActionCell(
        key: ValueKey(reminder.reminderId),
        leadingActions: [
          SwipeAction(
            title: S.current.accept_button,
            icon: const FaIcon(FontAwesomeIcons.check,
                color: AppColors.lightText),
            color: AppColors.success,
            forceAlignmentToBoundary: true,
            performsFirstActionWithFullSwipe: true,
            onTap: (handler) {},
          )
        ],
        trailingActions: [
          SwipeAction(
            performsFirstActionWithFullSwipe: true,
            color: AppColors.error,
            title: S.current.delete_button,
            icon: const FaIcon(FontAwesomeIcons.trash,
                color: AppColors.lightText),
            forceAlignmentToBoundary: true,
            onTap: (handler) {},
          )
        ],
        child: Container(
          decoration: BoxDecoration(
            color:
                context.isDarkMode ? AppColors.darkText : AppColors.lightText,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
          ),
          padding: const EdgeInsets.all(AppSpacing.paddingXS),
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.marginM,
            vertical: AppSpacing.marginS,
          ),
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: const FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.amber,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.reminderTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _spacing,
                Text(
                  '${S.current.notify_at} ${reminder.reminderTime.toMoment().formatTime()}',
                  style: const TextStyle(
                    fontSize: AppFontSize.bodyMedium,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                _spacing,
                IconWithText(
                  icon: FontAwesomeIcons.fire,
                  iconSize: 20,
                  iconColor: Colors.red,
                  fontSize: AppFontSize.bodyMedium,
                  text: S.current.total_streak(reminder.habitStreak),
                ),
              ],
            ),
            trailing: GestureDetector(
              child: const Icon(
                FontAwesomeIcons.solidCirclePause,
                color: AppColors.warning,
                size: _iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
