import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ant_design.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../domain/entities/achievements/accumulation_requirement.dart';
import '../../domain/entities/achievements/achievement_entity.dart';
import '../../domain/entities/achievements/achievement_requirement.dart';
import '../../domain/entities/achievements/streak_requirement.dart';
import '../../domain/entities/achievements/time_requirement.dart';

class AchievedGoalItem extends StatelessWidget {
  final AchievementEntity achievement;
  const AchievedGoalItem({super.key, required this.achievement});

  static const _spacing = SizedBox(height: AppSpacing.marginS);
  static const _subTitleColor = AppColors.grayText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusM)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingM, vertical: AppSpacing.paddingS),
      margin: const EdgeInsets.all(AppSpacing.marginS),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Iconify(
              achievement.achievementIcon.icon,
              color: achievement.achievementIcon.color,
            ),
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSpacing.paddingS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      achievement.achievementName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSize.h3,
                      ),
                      semanticsLabel: achievement.achievementName,
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  (achievement.isUnlocked)
                      ? _buildCheckIcon()
                      : TextWithCircleBorderContainer(
                          title: achievement
                              .achievementLevel.name.toUpperCaseFirstLetter,
                          backgroundColor: achievement.achievementLevel.color,
                        ),
                ],
              ),
            ),
            subtitle: Text(
              achievement.achievementDesc,
              maxLines: 10,
              style: TextStyle(
                color: _subTitleColor,
                fontSize: AppFontSize.bodyLarge,
              ),
            ),
          ),
          if (achievement.isUnlocked && achievement.unlockedDate != null) ...[
            _spacing,
            Align(
              alignment: Alignment.centerLeft,
              child: IconWithText(
                icon: FontAwesomeIcons.calendar,
                text: S.current.earned_at(achievement.unlockedDate!),
                iconSize: 20,
                fontSize: AppFontSize.labelLarge,
                fontColor: _subTitleColor,
                iconColor: _subTitleColor,
              ),
            ),
          ],
          _spacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithText(
                icon: FontAwesomeIcons.barsProgress,
                text: _buildCurrentProgress(achievement.achievementRequirement),
                iconSize: 20,
                fontSize: AppFontSize.labelLarge,
                fontColor: _subTitleColor,
                iconColor: _subTitleColor,
              ),
              Text(
                _buildTarget(achievement.achievementRequirement),
                style: TextStyle(
                  color: _subTitleColor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _buildCurrentProgress(AchievementRequirement requirement) {
    if (requirement is AccumulationRequirement) {
      return '${S.current.current_progress}: ${requirement.current.toStringAsFixedWithoutZero()} ${achievement.achievementRequirement.baseUnit.unitName.toUpperCaseFirstLetter}';
    } else if (requirement is TimeRequirement) {
      return DateTimeHelper.formatDuration(requirement.currentTime);
    } else if (requirement is StreakRequirement) {
      return '${S.current.longest_streak}: ${requirement.currentStreak.toStringAsFixedWithoutZero()}';
    }

    return '';
  }

  String _buildTarget(AchievementRequirement requirement) {
    if (requirement is AccumulationRequirement) {
      return '${requirement.target} ${requirement.baseUnit.unitName.toUpperCaseFirstLetter}';
    } else if (requirement is TimeRequirement) {
      return DateTimeHelper.formatDuration(requirement.targetTime);
    } else if (requirement is StreakRequirement) {
      return S.current.total_streak(requirement.requiredDays);
    }

    return '';
  }

  Widget _buildCheckIcon() {
    return Iconify(
      AntDesign.check_circle_fill,
      color: Colors.green,
    );
  }
}
