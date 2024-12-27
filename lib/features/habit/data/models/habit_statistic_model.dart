import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/habit_statistic_entity.dart';

part 'habit_statistic_model.g.dart';

@JsonSerializable()
class HabitStatisticModel extends HabitStatisticEntity {
  const HabitStatisticModel({
    required super.habitId,
    required super.totalTrackedDays,
    required super.totalCompletions,
    required super.averageRating,
    required super.mostCommonMood,
    required super.longestStreak,
    required super.totalDuration,
  });

  factory HabitStatisticModel.fromJson(Map<String, dynamic> json) =>
      _$HabitStatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$HabitStatisticModelToJson(this);

  factory HabitStatisticModel.fromEntity(HabitStatisticEntity entity) {
    return HabitStatisticModel(
      habitId: entity.habitId,
      totalTrackedDays: entity.totalTrackedDays,
      totalCompletions: entity.totalCompletions,
      averageRating: entity.averageRating,
      mostCommonMood: entity.mostCommonMood,
      longestStreak: entity.longestStreak,
      totalDuration: entity.totalDuration,
    );
  }

  HabitStatisticEntity toEntity() {
    return HabitStatisticEntity(
      habitId: habitId,
      totalTrackedDays: totalTrackedDays,
      totalCompletions: totalCompletions,
      averageRating: averageRating,
      mostCommonMood: mostCommonMood,
      longestStreak: longestStreak,
      totalDuration: totalDuration,
    );
  }
}
