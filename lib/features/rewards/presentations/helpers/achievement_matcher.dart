import '../../../../core/enums/habit/goal_unit.dart';
import '../../data/models/achievement_model.dart';
import '../../domain/entities/achievements/achievement_requirement.dart';

class AchievementMatcher {
  bool isHabitEligible(GoalUnit habitUnit, AchievementRequirement requirement) {
    return requirement.acceptableUnits.contains(habitUnit);
  }

  Future<List<AchievementModel>> findMatchingAchievements(
    List<AchievementModel> achievements,
    GoalUnit habitUnit,
  ) async {
    return achievements
        .where((achievement) =>
            isHabitEligible(habitUnit, achievement.achievementRequirement))
        .toList();
  }
}
