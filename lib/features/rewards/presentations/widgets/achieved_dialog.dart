import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/achievements/achievement_entity.dart';

class AchievementDialog {
  static void show({
    required BuildContext context,
    required AchievementEntity achievement,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      padding: EdgeInsets.all(AppSpacing.paddingS),
      headerAnimationLoop: false,
      alignment: Alignment.center,
      body: Column(
        children: [
          Text(
            '${S.current.congratulation_title}!! ${S.current.you_achieved(achievement.achievementName)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h4,
              overflow: TextOverflow.visible,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 2,
          ),
          AnimatedTextKit(
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
            animatedTexts: [
              TyperAnimatedText(
                achievement.achievementDesc,
                textAlign: TextAlign.center,
                curve: Curves.linear,
                textStyle: TextStyle(overflow: TextOverflow.visible),
              ),
            ],
          ),
        ],
      ),
    ).show();
  }
}
