import 'achievement_requirement.dart';

class TimeRequirement implements AchievementRequirement {
  final Duration targetTime;
  final Duration currentTime;

  TimeRequirement({
    required this.targetTime,
    this.currentTime = const Duration(),
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'targetTime': targetTime.inMilliseconds,
      'currentTime': currentTime.inMilliseconds,
    };
  }

  factory TimeRequirement.fromJson(Map<String, dynamic> json) {
    return TimeRequirement(
      targetTime: Duration(milliseconds: json['targetTime']),
      currentTime: Duration(milliseconds: json['currentTime']),
    );
  }
}
