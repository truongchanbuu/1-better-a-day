import 'package:hive_ce/hive.dart';

import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_icon.dart';
import '../../../../core/enums/habit/habit_status.dart';

import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import 'habit_goal_model.dart';
import 'habit_model.dart';

class PresetHabits {
  static final List<HabitModel> defaultHabits = [
    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-01',
      habitTitle: S.current.water_habit_title,
      habitDesc: S.current.water_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-01-01',
        habitId: 'PRESET-HEALTH-01',
        goalDesc: S.current.water_habit_goal_desc,
        goalType: GoalType.completion.name,
        currentValue: 0,
        targetValue: 2,
        goalFrequency: 1,
        goalUnit: GoalUnit.l.name,
      ),
      habitCategory: HabitCategory.health.name,
      iconName: HabitIcon.water.name,
      habitStatus: HabitStatus.pending.name,
      timeOfDay: HabitTimeOfDay.morning.name,
      reminderTime: '6:00',
    ),
    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-02',
      habitTitle: S.current.run_habit_title,
      habitDesc: S.current.run_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-02-01',
        habitId: 'PRESET-HEALTH-02',
        goalDesc: S.current.run_habit_goal_desc,
        goalType: GoalType.distance.name,
        currentValue: 0,
        targetValue: 2,
        goalFrequency: 1,
        goalUnit: GoalUnit.km.name,
      ),
      habitCategory: HabitCategory.health.name,
      iconName: HabitIcon.exercise.name,
      habitStatus: HabitStatus.pending.name,
      timeOfDay: HabitTimeOfDay.morning.name,
      reminderTime: '6:30',
    ),
    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-03',
      habitTitle: S.current.exercise_habit_title,
      habitDesc: S.current.exercise_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-03-01',
        habitId: 'PRESET-HEALTH-03',
        goalDesc: S.current.exercise_habit_goal_desc,
        goalType: GoalType.distance.name,
        currentValue: 0,
        targetValue: 30,
        goalFrequency: 1,
        goalUnit: GoalUnit.minute.name,
      ),
      habitCategory: HabitCategory.health.name,
      iconName: HabitIcon.exercise.name,
      habitStatus: HabitStatus.pending.name,
      timeOfDay: HabitTimeOfDay.morning.name,
      reminderTime: '6:30',
    ),
    HabitModel.init().copyWith(
      habitId: 'PRESET-MINDFULNESS-01',
      habitTitle: S.current.meditation_habit_title,
      habitDesc: S.current.meditation_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-MINDFULNESS-01-01',
        habitId: 'PRESET-MINDFULNESS-01',
        goalDesc: S.current.meditation_habit_goal_desc,
        goalType: GoalType.duration.name,
        currentValue: 0,
        targetValue: 5,
        goalFrequency: 1,
        goalUnit: GoalUnit.minute.name,
      ),
      habitCategory: HabitCategory.mindfulness.name,
      iconName: HabitIcon.exercise.name,
      habitStatus: HabitStatus.pending.name,
      timeOfDay: HabitTimeOfDay.morning.name,
      reminderTime: '6:45',
    ),
    HabitModel.init().copyWith(
      habitId: 'PRESET-LEARNING-01',
      habitTitle: S.current.reading_habit_title,
      habitDesc: S.current.reading_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-LEARNING-01-01',
        habitId: 'PRESET-LEARNING-01',
        goalDesc: S.current.reading_habit_goal_desc,
        goalType: GoalType.count.name,
        currentValue: 0,
        targetValue: 10,
        goalFrequency: 1,
        goalUnit: GoalUnit.page.name,
      ),
      habitCategory: HabitCategory.education.name,
      iconName: HabitIcon.reading.name,
      habitStatus: HabitStatus.pending.name,
      timeOfDay: HabitTimeOfDay.anytime.name,
      reminderTime: '20:00',
    ),
    HabitModel.init().copyWith(
      habitId: 'PRESET-LEARNING-02',
      habitTitle: S.current.study_habit_title,
      habitDesc: S.current.study_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-LEARNING-02-01',
        habitId: 'PRESET-LEARNING-02',
        goalDesc: S.current.study_habit_goal_desc,
        goalType: GoalType.duration.name,
        currentValue: 0,
        targetValue: 120,
        goalFrequency: 1,
        goalUnit: GoalUnit.minute.name,
      ),
      habitCategory: HabitCategory.education.name,
      iconName: HabitIcon.reading.name,
      habitStatus: HabitStatus.pending.name,
      timeOfDay: HabitTimeOfDay.evening.name,
      reminderTime: '19:00',
    ),
  ];

  static Future<void> initializePresetHabits() async {
    final habitBox =
        getIt.get<Box<Map<String, dynamic>>>(instanceName: 'habitBox');

    if (habitBox.isEmpty) {
      await habitBox.addAll(defaultHabits.map((e) => e.toJson()));
    }
  }
}
