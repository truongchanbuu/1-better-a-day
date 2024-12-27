import 'package:json_annotation/json_annotation.dart';

import '../../../../core/resources/hive_base_model.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_goal.dart';
import 'habit_goal_model.dart';

part 'habit_model.g.dart';

@JsonSerializable()
class HabitModel extends HabitEntity implements HiveBaseModel<HabitModel> {
  HabitModel({
    required super.habitId,
    required super.habitTitle,
    super.iconName,
    required super.habitDesc,
    required super.habitProgress,
    required HabitGoalModel habitGoal,
    required super.habitCategory,
    required super.timeOfDay,
    required super.currentStreak,
    required super.longestStreak,
    required super.startDate,
    required super.endDate,
    super.reminderTime,
    required super.habitStatus,
  }) : super(habitGoal: habitGoal.toEntity());

  factory HabitModel.init() {
    return HabitModel(
      habitId: '',
      habitTitle: '',
      habitDesc: '',
      habitProgress: 0,
      habitGoal: HabitGoalModel.fromEntity(HabitGoal.init()),
      habitCategory: '',
      timeOfDay: '',
      currentStreak: 0,
      longestStreak: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 21)),
      habitStatus: '',
      iconName: '',
      reminderTime: '',
    );
  }

  HabitEntity toEntity() {
    return HabitEntity(
      habitId: habitId,
      habitTitle: habitTitle,
      habitDesc: habitDesc,
      habitGoal: habitGoal,
      habitCategory: habitCategory,
      timeOfDay: timeOfDay,
      endDate: endDate,
      habitStatus: habitStatus,
      startDate: startDate,
      habitProgress: habitProgress,
      iconName: iconName,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      reminderTime: reminderTime,
    );
  }

  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      habitId: entity.habitId,
      habitTitle: entity.habitTitle,
      habitDesc: entity.habitDesc,
      habitProgress: entity.habitProgress,
      habitGoal: HabitGoalModel.fromEntity(entity.habitGoal),
      habitCategory: entity.habitCategory,
      timeOfDay: entity.timeOfDay,
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
      startDate: entity.startDate,
      endDate: entity.endDate,
      habitStatus: entity.habitStatus,
      reminderTime: entity.reminderTime,
      iconName: entity.iconName,
    );
  }

  @override
  HabitModel copyWith({
    String? habitId,
    String? habitTitle,
    String? iconName,
    String? habitDesc,
    HabitGoal? habitGoal,
    String? habitCategory,
    double? habitProgress,
    String? timeOfDay,
    int? currentStreak,
    int? longestStreak,
    DateTime? startDate,
    DateTime? endDate,
    String? reminderTime,
    String? habitStatus,
  }) {
    return HabitModel(
      habitId: habitId ?? this.habitId,
      habitTitle: habitTitle ?? this.habitTitle,
      iconName: iconName ?? this.iconName,
      habitDesc: habitDesc ?? this.habitDesc,
      habitProgress: habitProgress ?? this.habitProgress,
      habitGoal: HabitGoalModel.fromEntity(habitGoal ?? this.habitGoal),
      habitCategory: habitCategory ?? this.habitCategory,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTime: reminderTime ?? this.reminderTime,
      habitStatus: habitStatus ?? this.habitStatus,
    );
  }

  factory HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);

  Map<String, dynamic> toJson() => _$HabitModelToJson(this);

  @override
  List<Object?> get props {
    return [
      habitId,
      habitTitle,
      iconName,
      habitDesc,
      habitProgress,
      habitGoal,
      habitCategory,
      timeOfDay,
      currentStreak,
      longestStreak,
      startDate,
      endDate,
      reminderTime,
      habitStatus,
    ];
  }

  @override
  HabitModel fromMap(Map<String, dynamic> map) {
    try {
      final convertedMap = Map<String, dynamic>.from(map);

      final habitGoalData = map['habitGoal'];
      if (habitGoalData is Map<dynamic, dynamic>) {
        final convertedGoalMap = <String, dynamic>{};
        habitGoalData.forEach((key, value) {
          convertedGoalMap[key.toString()] = value;
        });
        convertedMap['habitGoal'] = convertedGoalMap;
      } else {
        throw const FormatException('Invalid habitGoal format');
      }

      return HabitModel.fromJson(convertedMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  get key => habitId;

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
