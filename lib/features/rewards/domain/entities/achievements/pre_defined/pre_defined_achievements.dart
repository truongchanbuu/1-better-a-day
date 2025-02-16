import 'package:colorful_iconify_flutter/icons/fluent_emoji_flat.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/icons/akar_icons.dart';
import 'package:iconify_flutter_plus/icons/ant_design.dart';
import 'package:iconify_flutter_plus/icons/iconoir.dart';
import 'package:iconify_flutter_plus/icons/ion.dart';
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
    AchievementEntity(
      achievementId: "streak_hero_14_day_in_line",
      achievementName: "Fortnight Hero",
      achievementDesc:
          "Incredible! You've maintained a 14-day streak, proving your resilience and dedication. Keep pushing your limits, hero! ⚔️🔥",
      achievementType: AchievementType.streak,
      achievementRequirement: StreakRequirement(
        requiredDays: 14,
        acceptableUnits: {GoalUnit.day},
        baseUnit: GoalUnit.day,
      ),
      achievementIcon: HabitIcon(
        key: 'streak_hero_14_day_in_line',
        icon: AkarIcons.double_sword,
        color: Color(0xFFFFD700),
      ),
      achievementLevel: AchievementLevel.rare,
      isUnlocked: false,
    ),
    AchievementEntity(
      achievementId: "streak_legend_30_day_in_line",
      achievementName: "30-Day Legend",
      achievementDesc:
          "Legendary! A 30-day streak is no small feat. You've etched your name into the hall of consistency! 🏆🌟",
      achievementType: AchievementType.streak,
      achievementRequirement: StreakRequirement(
        requiredDays: 30,
        acceptableUnits: {GoalUnit.day},
        baseUnit: GoalUnit.day,
      ),
      achievementIcon: HabitIcon(
        key: 'streak_legend_30_day_in_line',
        icon: AkarIcons.crown,
        color: Color(0xFFFFA500),
      ),
      achievementLevel: AchievementLevel.epic,
      isUnlocked: false,
    ),
    AchievementEntity(
      achievementId: "streak_immortal_60_day_in_line",
      achievementName: "Immortal Streak",
      achievementDesc:
          "Unstoppable! 60 days straight is a testament to your unyielding commitment. 🌟⚡",
      achievementType: AchievementType.streak,
      achievementRequirement: StreakRequirement(
        requiredDays: 60,
        acceptableUnits: {GoalUnit.day},
        baseUnit: GoalUnit.day,
      ),
      achievementIcon: HabitIcon(
        key: 'streak_immortal_60_day_in_line',
        icon: Lucide.shield_check,
        color: Color(0xFF00CED1),
      ),
      achievementLevel: AchievementLevel.legendary,
      isUnlocked: false,
    ),
  ];

  static List<AchievementEntity> accumulativeAchievements = [
    // TEST:
    AchievementEntity(
      achievementId: "test_aqua",
      achievementName: "Aqua Guardian TEST",
      achievementDesc:
          "Hydration Champion, you have proven yourself a true guardian of well-being! With every sip, you fortify your body, maintaining the balance of life 💧🛡️.",
      achievementType: AchievementType.accumulation,
      achievementRequirement: AccumulationRequirement(
        target: 250,
        acceptableUnits: {
          GoalUnit.l,
          GoalUnit.ml,
          GoalUnit.glasses,
        },
        baseUnit: GoalUnit.ml,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "test_aqua",
        icon: Lucide.droplets,
        color: Color(0xFF0000FF),
      ),
      achievementLevel: AchievementLevel.common,
    ),

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
    AchievementEntity(
      achievementId: "run_for_100_m",
      achievementName: "Footer Apprentice",
      achievementDesc:
          "Congratulations! You've run/walk 100m in a single day. Every step counts on your journey to greatness! 👣🏅",
      achievementType: AchievementType.accumulation,
      achievementRequirement: AccumulationRequirement(
        target: 100,
        acceptableUnits: {GoalUnit.m, GoalUnit.km, GoalUnit.miles},
        baseUnit: GoalUnit.m,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "run_for_100_m",
        icon: Ion.walk,
        color: Color(0xFF32CD32),
      ),
      achievementLevel: AchievementLevel.common,
    ),
    AchievementEntity(
      achievementId: "reading_sage_500_pages",
      achievementName: "Reading Sage",
      achievementDesc:
          "Wise one! You've read 500 pages. Knowledge is your superpower. Keep turning those pages! 📖🧠",
      achievementType: AchievementType.accumulation,
      achievementRequirement: AccumulationRequirement(
        target: 500,
        acceptableUnits: {GoalUnit.page},
        baseUnit: GoalUnit.page,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "reading_sage_500_pages",
        icon: Lucide.book_open,
        color: Color(0xFF8B4513),
      ),
      achievementLevel: AchievementLevel.rare,
    ),
    AchievementEntity(
      achievementId: "step_conqueror_100_km",
      achievementName: "Foot Conqueror",
      achievementDesc:
          "Amazing! You've conquered 100 km in total. Every step is a victory on your journey. 🚶‍♂️🏔️",
      achievementType: AchievementType.accumulation,
      achievementRequirement: AccumulationRequirement(
        target: 100,
        acceptableUnits: {GoalUnit.km, GoalUnit.m, GoalUnit.miles},
        baseUnit: GoalUnit.km,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "step_conqueror_100_km",
        icon: FluentEmojiFlat.running_shoe,
        color: Color(0xFF228B22),
      ),
      achievementLevel: AchievementLevel.legendary,
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
    AchievementEntity(
      achievementId: "focus_master_120_minutes",
      achievementName: "Focus Master",
      achievementDesc:
          "You've achieved 120 minutes of deep work! Laser-sharp focus is your key to success. 🎯🧠",
      achievementType: AchievementType.time,
      achievementRequirement: TimeRequirement(
        targetTime: Duration(minutes: 120),
        acceptableUnits: {GoalUnit.minute, GoalUnit.hour},
        baseUnit: GoalUnit.minute,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "focus_master_120_minutes",
        icon: AntDesign.bulb,
        color: Color(0xFF9370DB),
      ),
      achievementLevel: AchievementLevel.common,
    ),
    AchievementEntity(
      achievementId: "zen_guru_300_minutes",
      achievementName: "Zen Guru",
      achievementDesc:
          "You've meditated for 300 minutes total! Peace flows through your veins like a gentle river. 🧘🌊",
      achievementType: AchievementType.time,
      achievementRequirement: TimeRequirement(
        targetTime: Duration(minutes: 300),
        acceptableUnits: {GoalUnit.minute, GoalUnit.hour},
        baseUnit: GoalUnit.minute,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "zen_guru_300_minutes",
        icon: FluentEmojiFlat.person_in_lotus_position,
        color: Color(0xFF4682B4),
      ),
      achievementLevel: AchievementLevel.rare,
    ),
    AchievementEntity(
      achievementId: "focus_grandmaster_600_minutes",
      achievementName: "Focus Grandmaster",
      achievementDesc:
          "You've maintained focus for 600 minutes total! Your mind is an indomitable fortress. 🧠🏆",
      achievementType: AchievementType.time,
      achievementRequirement: TimeRequirement(
        targetTime: Duration(minutes: 600),
        acceptableUnits: {GoalUnit.minute, GoalUnit.hour},
        baseUnit: GoalUnit.minute,
      ),
      isUnlocked: false,
      achievementIcon: HabitIcon(
        key: "focus_grandmaster_600_minutes",
        icon: Iconoir.light_bulb_on,
        color: Color(0xFF6A5ACD),
      ),
      achievementLevel: AchievementLevel.legendary,
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
