import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/resources/hive_base_model.dart';
import '../../domain/entities/habit_frequency.dart';
import '../../domain/entities/habit_goal.dart';

part 'habit_goal_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitGoalModel extends HabitGoal
    implements HiveBaseModel<HabitGoalModel> {
  @JsonKey(fromJson: _goalFrequencyFromJson, name: 'goalFrequency')
  final HabitFrequency goalFreq;

  const HabitGoalModel({
    required super.goalId,
    required super.habitId,
    required super.goalDesc,
    required super.goalType,
    required super.targetValue,
    required this.goalFreq,
    required super.goalUnit,
  }) : super(goalFrequency: goalFreq);

  HabitGoal toEntity() {
    return HabitGoal(
      goalId: goalId,
      habitId: habitId,
      goalDesc: goalDesc,
      goalType: goalType,
      targetValue: targetValue,
      goalUnit: goalUnit,
      goalFrequency: goalFrequency,
    );
  }

  factory HabitGoalModel.fromEntity(HabitGoal entity) {
    return HabitGoalModel(
      goalId: entity.goalId,
      habitId: entity.habitId,
      goalDesc: entity.goalDesc,
      goalType: entity.goalType,
      targetValue: entity.targetValue,
      goalFreq: entity.goalFrequency,
      goalUnit: entity.goalUnit,
    );
  }

  @override
  HabitGoalModel copyWith({
    String? goalId,
    String? habitId,
    String? goalDesc,
    GoalType? goalType,
    double? currentValue,
    double? targetValue,
    HabitFrequency? goalFrequency,
    GoalUnit? goalUnit,
  }) {
    return HabitGoalModel(
      goalId: goalId ?? this.goalId,
      habitId: habitId ?? this.habitId,
      goalDesc: goalDesc ?? this.goalDesc,
      goalType: goalType ?? this.goalType,
      targetValue: targetValue ?? this.targetValue,
      goalFreq: goalFrequency ?? this.goalFrequency,
      goalUnit: goalUnit ?? this.goalUnit,
    );
  }

  Map<String, dynamic> toJson() => _$HabitGoalModelToJson(this);

  factory HabitGoalModel.fromJson(Map<String, dynamic> json) =>
      _$HabitGoalModelFromJson(json);

  static HabitFrequency _goalFrequencyFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return HabitFrequency.fromJson(json);
    } else if (json is Map<dynamic, dynamic>) {
      return HabitFrequency.fromJson(Map<String, dynamic>.from(json));
    } else {
      throw const FormatException('Invalid format for goalFrequency');
    }
  }

  @override
  List<Object> get props {
    return [
      goalId,
      habitId,
      goalDesc,
      goalType,
      targetValue,
      goalFrequency,
      goalUnit,
    ];
  }

  @override
  HabitGoalModel fromMap(Map<String, dynamic> map) {
    try {
      final convertedMap = Map<String, dynamic>.from(map);

      final goalFreq = map['goalFrequency'];
      if (goalFreq is Map<dynamic, dynamic>) {
        final convertedGoalFreq = <String, dynamic>{};
        goalFreq.forEach((k, v) => convertedGoalFreq[k.toString()] = v);
        convertedMap['goalFrequency'] = convertedGoalFreq;
      } else {
        throw const FormatException('Invalid goal frequency format');
      }

      return HabitGoalModel.fromJson(convertedMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  get key => goalId;

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
