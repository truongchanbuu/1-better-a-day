import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/reminder/reminder_status.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/reminder_entity.dart';
import '../widgets/reminder_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grayBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildScreenTitle(),
              ...List.generate(
                10,
                (index) => ReminderItem(
                  reminder: ReminderEntity(
                    reminderId: index.toString(),
                    reminderTitle: 'REMINDER $index',
                    habitId: 'habit$index',
                    reminderTime: DateTime.now()
                        .copyWith(hour: index, minute: index * 10 + index),
                    reminderStatus:
                        ReminderStatus.values[Random().nextInt(3)].name,
                    habitStreak: 3,
                    createdAt: DateTime.now(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenTitle() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusM)),
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        vertical: AppSpacing.marginM,
        horizontal: AppSpacing.marginL,
      ),
      padding: const EdgeInsets.all(AppSpacing.marginM),
      child: AnimatedTextKit(
        repeatForever: false,
        totalRepeatCount: 1,
        animatedTexts: [
          TyperAnimatedText(
            S.current.notification_screen_title,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h2,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }
}
