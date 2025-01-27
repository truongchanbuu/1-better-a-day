import 'package:colorful_iconify_flutter/icons/fluent_emoji_flat.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/icons/akar_icons.dart';
import 'package:iconify_flutter_plus/icons/lucide.dart';

import '../../../../../../core/enums/habit/goal_unit.dart';
import '../../../../../../core/enums/rewards/achievement_level.dart';
import '../../../../../../core/enums/rewards/achievement_type.dart';
import '../../../../../../injection_container.dart';
import '../../../../../habit/domain/entities/habit_icon.dart';
import '../../../../data/models/achievement_model.dart';
import '../../../repositories/achievement_repository.dart';
import '../accumulation_requirement.dart';
import '../achievement_entity.dart';
import '../streak_requirement.dart';
import '../time_requirement.dart';

class PreDefinedAchievements {
  static List<AchievementEntity> streakAchievements = [
    AchievementEntity(
      achievementId: "streak_warrior_7_day_in_line",
      achievementName: "7-day Long Survival Warrior",
      achievementDesc:
          "Steadfast warrior, you've conquered the 7-day streak with unwavering determination. Your resolve stands tall in the battle against time. Carry on with honor\nCongratulations! Keep your spirit strong and your path clear 🛡️🗡️.",
      achievementType: AchievementType.streak,
      achievementRequirement: StreakRequirement(
        requiredDays: 7,
        acceptableUnits: {GoalUnit.day},
        baseUnit: GoalUnit.day,
      ),
      achievementIcon: HabitIcon(
        key: 'streak_warrior_7_day_in_line',
        icon: AkarIcons.double_sword,
        color: Color(0xFFC0C0C0),
      ),
      achievementLevel: AchievementLevel.common,
      isUnlocked: false,
    ),
  ];

  static List<AchievementEntity> accumulativeAchievements = [
    AchievementEntity(
      achievementId: "aqua_guardian_2_l_a_day",
      achievementName: "Aqua Guardian",
      achievementDesc:
          "Hydration Champion, you have proven yourself a true guardian of well-being! With every sip, you fortify your body, maintaining the balance of life 💧🛡️.",
      achievementType: AchievementType.accumulation,
      achievementRequirement: AccumulationRequirement(
        target: 2,
        acceptableUnits: {
          GoalUnit.l,
          GoalUnit.ml,
          GoalUnit.glasses,
        },
        baseUnit: GoalUnit.l,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "aqua_guardian_2_l_a_day",
        icon: Lucide.droplets,
        color: Color(0xFF0000FF),
      ),
      achievementLevel: AchievementLevel.common,
    ),
  ];

  static List<AchievementEntity> timeRequirementAchievements = [
    AchievementEntity(
      achievementId: "chill_guy_for_a_week",
      achievementName: "Chill Guy",
      achievementDesc:
          "Chill Guy, you have embraced the tranquility within and mastered the art of meditation. By dedicating 10 minutes each day for an entire week\nKeep up the great work in finding your inner calm and maintaining this mindful practice! 🌿🧘‍♂️✨.",
      achievementType: AchievementType.time,
      achievementRequirement: TimeRequirement(
        targetTime: Duration(minutes: 70),
        acceptableUnits: {GoalUnit.minute, GoalUnit.hour, GoalUnit.second},
        baseUnit: GoalUnit.minute,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "chill_guy_for_a_week",
        icon: FluentEmojiFlat.person_in_lotus_position,
      ),
      achievementLevel: AchievementLevel.common,
    ),
  ];

  static List<AchievementEntity> get allAchievements => [
        ...PreDefinedAchievements.streakAchievements,
        ...PreDefinedAchievements.accumulativeAchievements,
        ...PreDefinedAchievements.timeRequirementAchievements,
      ]..sort((a, b) => a.achievementName.compareTo(b.achievementName));

  static Future<void> storeAllPredefinedAchievements() async {
    final achievementRepository = getIt.get<AchievementRepository>();
    final allLocalAchievements =
        await achievementRepository.getAllLocalAchievements();

    for (final achievement in allAchievements) {
      try {
        if (!allLocalAchievements
            .map((e) => e.achievementId)
            .contains(achievement.achievementId)) {
          await achievementRepository
              .createAchievement(AchievementModel.fromEntity(achievement));
        }
      } catch (e) {
        debugPrint(
            'Error storing achievement ${achievement.achievementName}: $e');
      }
    }
  }
}
