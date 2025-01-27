import 'package:moment_dart/moment_dart.dart';

import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/helpers/duration_helper.dart';
import '../../domain/entities/achievements/accumulation_requirement.dart';
import '../../domain/entities/achievements/achievement_requirement.dart';
import '../../domain/entities/achievements/streak_requirement.dart';
import '../../domain/entities/achievements/time_requirement.dart';

abstract class RequirementHandler {
  bool canHandle(AchievementRequirement requirement);
  AchievementRequirement processUpdate(
    AchievementRequirement requirement,
    GoalUnit habitUnit,
    dynamic value,
  );
}

class AccumulationHandler extends RequirementHandler {
  @override
  bool canHandle(AchievementRequirement requirement) =>
      requirement is AccumulationRequirement;

  @override
  AchievementRequirement processUpdate(
    AchievementRequirement requirement,
    GoalUnit habitUnit,
    dynamic value,
  ) {
    final req = requirement as AccumulationRequirement;
    return req.checkAndUpdate(value);
  }
}

class TimeRequirementHandler extends RequirementHandler {
  @override
  bool canHandle(AchievementRequirement requirement) =>
      requirement is TimeRequirement;

  @override
  AchievementRequirement processUpdate(
      AchievementRequirement requirement, GoalUnit habitUnit, dynamic value) {
    final req = requirement as TimeRequirement;
    final duration = DurationHelper.getDurationFromGoalUnit(
      value,
      GoalUnit.minute,
    );

    print('MY: $value = ${duration?.toDurationString()}');
    return req.checkAndUpdate(duration);
  }
}

class StreakHandler extends RequirementHandler {
  @override
  bool canHandle(AchievementRequirement requirement) =>
      requirement is StreakRequirement;

  @override
  AchievementRequirement processUpdate(
      AchievementRequirement requirement, GoalUnit habitUnit, dynamic value) {
    final req = requirement as StreakRequirement;
    return req.checkAndUpdate(value == 1);
  }
}
