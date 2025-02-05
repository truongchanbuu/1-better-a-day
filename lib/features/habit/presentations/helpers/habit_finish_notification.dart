import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_entity.dart';

class HabitFinishNotification {
  static final titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AppFontSize.h4,
  );
  static final descriptionStyle = TextStyle(overflow: TextOverflow.visible);
  static final duration = Duration(seconds: 10);
  static final double notificationHeight = 150.0;

  static void showSuccessNotification(BuildContext context, HabitEntity habit) {
    ElegantNotification.success(
      height: notificationHeight,
      title: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.paddingS),
        child: Text(S.current.success_title, style: titleStyle),
      ),
      description: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingS).copyWith(left: 0),
        child: Text(
          S.current.habit_achieved_title(habit.habitTitle),
          style: descriptionStyle,
          maxLines: 3,
        ),
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: AppSpacing.paddingS),
        child: Icon(
          FontAwesomeIcons.circleCheck,
          color: AppColors.success,
        ),
      ),
      displayCloseButton: false,
      progressIndicatorBackground: AppColors.primary,
      progressBarPadding: EdgeInsets.only(top: AppSpacing.marginS),
      toastDuration: duration,
    ).show(context);
  }

  static void showFailureNotification(BuildContext context, HabitEntity habit) {
    ElegantNotification.error(
      height: notificationHeight,
      title: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.paddingS),
        child: Text(S.current.failure_title, style: titleStyle),
      ),
      description: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingS).copyWith(left: 0),
        child: Text(
          S.current.habit_failed_title(habit.habitTitle,
              habit.habitProgress.toStringAsFixedWithoutZero()),
          style: descriptionStyle,
          maxLines: 3,
        ),
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: AppSpacing.paddingS),
        child: Icon(
          FontAwesomeIcons.triangleExclamation,
          color: AppColors.error,
        ),
      ),
      displayCloseButton: false,
      progressIndicatorBackground: AppColors.error,
      progressBarPadding: EdgeInsets.only(top: AppSpacing.marginS),
      toastDuration: duration,
    ).show(context);
  }
}
