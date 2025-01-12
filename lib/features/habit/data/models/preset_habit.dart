import 'package:hive_ce/hive.dart';

import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_frequency.dart';
import '../../domain/entities/habit_icon.dart';
import '../../../../core/enums/habit/habit_status.dart';

import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import 'habit_goal_model.dart';
import 'habit_model.dart';

class PresetHabits {
  static final List<HabitEntity> defaultHabits = [
    // TEST ONLY
    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-03',
      habitTitle: S.current.exercise_habit_title,
      habitDesc: S.current.exercise_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-03-01',
        habitId: 'PRESET-HEALTH-03',
        goalDesc: S.current.exercise_habit_goal_desc,
        goalType: GoalType.completion,
        targetValue: 30,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.second,
      ),
      habitCategory: HabitCategory.health,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.exercise),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.morning,
      reminderTimes: {'6:30'},
    ).toEntity(),
    //

    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-01',
      habitTitle: S.current.water_habit_title,
      habitDesc: S.current.water_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-01-01',
        habitId: 'PRESET-HEALTH-01',
        goalDesc: S.current.water_habit_goal_desc,
        goalType: GoalType.completion,
        targetValue: 2,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.l,
      ),
      habitCategory: HabitCategory.health,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.water),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.morning,
      reminderTimes: {'6:30'},
    ),
    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-02',
      habitTitle: S.current.run_habit_title,
      habitDesc: S.current.run_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-02-01',
        habitId: 'PRESET-HEALTH-02',
        goalDesc: S.current.run_habit_goal_desc,
        goalType: GoalType.distance,
        targetValue: 2,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.km,
      ),
      habitCategory: HabitCategory.health,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.exercise),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.morning,
      reminderTimes: {'6:30'},
    ).toEntity(),
    HabitModel.init().copyWith(
      habitId: 'PRESET-HEALTH-03',
      habitTitle: S.current.exercise_habit_title,
      habitDesc: S.current.exercise_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-HEALTH-03-01',
        habitId: 'PRESET-HEALTH-03',
        goalDesc: S.current.exercise_habit_goal_desc,
        goalType: GoalType.completion,
        targetValue: 30,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.minutes,
      ),
      habitCategory: HabitCategory.health,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.exercise),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.morning,
      reminderTimes: {'6:30'},
    ).toEntity(),
    HabitModel.init().copyWith(
      habitId: 'PRESET-MINDFULNESS-01',
      habitTitle: S.current.meditation_habit_title,
      habitDesc: S.current.meditation_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-MINDFULNESS-01-01',
        habitId: 'PRESET-MINDFULNESS-01',
        goalDesc: S.current.meditation_habit_goal_desc,
        goalType: GoalType.duration,
        targetValue: 5,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.minutes,
      ),
      habitCategory: HabitCategory.mindfulness,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.exercise),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.morning,
      reminderTimes: {'6:30'},
    ).toEntity(),
    HabitModel.init().copyWith(
      habitId: 'PRESET-LEARNING-01',
      habitTitle: S.current.reading_habit_title,
      habitDesc: S.current.reading_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-LEARNING-01-01',
        habitId: 'PRESET-LEARNING-01',
        goalDesc: S.current.reading_habit_goal_desc,
        goalType: GoalType.count,
        targetValue: 10,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.page,
      ),
      habitCategory: HabitCategory.education,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.education),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.anytime,
      reminderTimes: {'7:00'},
    ).toEntity(),
    HabitModel.init().copyWith(
      habitId: 'PRESET-LEARNING-02',
      habitTitle: S.current.study_habit_title,
      habitDesc: S.current.study_habit_desc,
      habitGoal: HabitGoalModel(
        goalId: 'PRESET-LEARNING-02-01',
        habitId: 'PRESET-LEARNING-02',
        goalDesc: S.current.study_habit_goal_desc,
        goalType: GoalType.duration,
        targetValue: 120,
        goalFreq: HabitFrequency.daily,
        goalUnit: GoalUnit.minutes,
      ),
      habitCategory: HabitCategory.education,
      habitIcon: HabitIcon.fromKey(PredefinedHabitIconKey.education),
      habitStatus: HabitStatus.pending,
      timeOfDay: HabitTimeOfDay.evening,
      reminderTimes: {'19:00'},
    ).toEntity(),
  ];

  static Future<void> initializePresetHabits() async {
    final habitBox =
        getIt.get<Box<Map<String, dynamic>>>(instanceName: 'habitBox');

    if (habitBox.isEmpty) {
      await habitBox
          .addAll(defaultHabits.map((e) => HabitModel.fromEntity(e).toJson()));
    }
  }
}
