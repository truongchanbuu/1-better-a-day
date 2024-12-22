import 'package:json_annotation/json_annotation.dart';

import '../../../../core/resources/hive_base_model.dart';
import '../../domain/entities/habit_goal.dart';

part 'habit_goal_model.g.dart';

@JsonSerializable()
class HabitGoalModel extends HabitGoal
    implements HiveBaseModel<HabitGoalModel> {
  const HabitGoalModel({
    required super.goalId,
    required super.habitId,
    required super.goalDesc,
    required super.goalType,
    required super.currentValue,
    required super.targetValue,
    required super.goalFrequency,
    required super.goalUnit,
  });

  HabitGoal toEntity() {
    return HabitGoal(
      goalId: goalId,
      habitId: habitId,
      goalDesc: goalDesc,
      goalType: goalType,
      targetValue: targetValue,
      goalUnit: goalUnit,
      goalFrequency: goalFrequency,
      currentValue: currentValue,
    );
  }

  factory HabitGoalModel.fromEntity(HabitGoal entity) {
    return HabitGoalModel(
      goalId: entity.goalId,
      habitId: entity.habitId,
      goalDesc: entity.goalDesc,
      goalType: entity.goalType,
      currentValue: entity.currentValue,
      targetValue: entity.targetValue,
      goalFrequency: entity.goalFrequency,
      goalUnit: entity.goalUnit,
    );
  }

  @override
  HabitGoalModel copyWith({
    String? goalId,
    String? habitId,
    String? goalDesc,
    String? goalType,
    double? currentValue,
    double? targetValue,
    int? goalFrequency,
    String? goalUnit,
  }) {
    return HabitGoalModel(
      goalId: goalId ?? this.goalId,
      habitId: habitId ?? this.habitId,
      goalDesc: goalDesc ?? this.goalDesc,
      goalType: goalType ?? this.goalType,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      goalFrequency: goalFrequency ?? this.goalFrequency,
      goalUnit: goalUnit ?? this.goalUnit,
    );
  }

  Map<String, dynamic> toJson() => _$HabitGoalModelToJson(this);

  factory HabitGoalModel.fromJson(Map<String, dynamic> json) =>
      _$HabitGoalModelFromJson(json);

  @override
  List<Object> get props {
    return [
      goalId,
      habitId,
      goalDesc,
      goalType,
      currentValue,
      targetValue,
      goalFrequency,
      goalUnit,
    ];
  }

  @override
  HabitGoalModel fromMap(Map<String, dynamic> map) {
    return HabitGoalModel.fromJson(map);
  }

  @override
  get key => goalId;

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
