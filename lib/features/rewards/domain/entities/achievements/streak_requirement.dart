import 'achievement_requirement.dart';

class StreakRequirement implements AchievementRequirement {
  final int requiredDays;
  final int currentStreak;
  final DateTime? lastUpdated;

  StreakRequirement({
    required this.requiredDays,
    this.currentStreak = 0,
    this.lastUpdated,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'requiredDays': requiredDays,
      'currentStreak': currentStreak,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory StreakRequirement.fromJson(Map<String, dynamic> json) {
    return StreakRequirement(
      requiredDays: json['requiredDays'],
      currentStreak: json['currentStreak'],
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }
}
