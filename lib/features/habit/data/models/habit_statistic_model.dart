import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/habit_statistic_entity.dart';

part 'habit_statistic_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitStatisticModel extends HabitStatisticEntity {
  const HabitStatisticModel({
    super.achievedHabits,
    super.achievementsCompleted,
    super.activeHabits,
    super.completionRate,
    super.completionRateChange,
    super.failedHabits,
    super.longestStreak,
    super.pausedHabits,
    super.totalHabits,
    super.trendPercentage,
  });

  factory HabitStatisticModel.fromJson(Map<String, dynamic> json) =>
      _$HabitStatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$HabitStatisticModelToJson(this);

  factory HabitStatisticModel.fromEntity(HabitStatisticEntity entity) {
    return HabitStatisticModel(
      longestStreak: entity.longestStreak,
      achievedHabits: entity.achievedHabits,
      achievementsCompleted: entity.achievementsCompleted,
      activeHabits: entity.activeHabits,
      completionRate: entity.completionRate,
      completionRateChange: entity.completionRateChange,
      failedHabits: entity.failedHabits,
      pausedHabits: entity.pausedHabits,
      totalHabits: entity.totalHabits,
      trendPercentage: entity.trendPercentage,
    );
  }

  HabitStatisticEntity toEntity() {
    return HabitStatisticEntity(
      trendPercentage: trendPercentage,
      totalHabits: totalHabits,
      pausedHabits: pausedHabits,
      failedHabits: failedHabits,
      completionRateChange: completionRateChange,
      completionRate: completionRate,
      activeHabits: activeHabits,
      achievementsCompleted: achievementsCompleted,
      achievedHabits: achievedHabits,
      longestStreak: longestStreak,
    );
  }
}
