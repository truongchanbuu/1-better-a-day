import '../achievement_requirement.dart';

class StreakRequirement implements AchievementRequirement {
  final int requiredDays;
  final int currentStreak;
  final DateTime? lastUpdated;

  StreakRequirement({
    required this.requiredDays,
    this.currentStreak = 0,
    this.lastUpdated,
  });
}
