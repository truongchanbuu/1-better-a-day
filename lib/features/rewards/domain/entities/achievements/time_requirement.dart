import '../achievement_requirement.dart';

class TimeRequirement implements AchievementRequirement {
  final Duration targetTime;
  final Duration currentTime;

  TimeRequirement({
    required this.targetTime,
    this.currentTime = const Duration(),
  });
}
