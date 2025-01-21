import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../../../core/enums/rewards/achievement_level.dart';
import '../../../../../injection_container.dart';
import '../../../../habit/domain/entities/habit_entity.dart';
import '../../../domain/entities/achievements/accumulation_requirement.dart';
import '../../../domain/entities/achievements/achievement_entity.dart';
import '../../../domain/repositories/achievement_repository.dart';

part 'challenge_crud_event.dart';
part 'challenge_crud_state.dart';

class ChallengeCrudBloc extends Bloc<ChallengeCrudEvent, ChallengeCrudState> {
  final AchievementRepository achievementRepository;

  ChallengeCrudBloc(this.achievementRepository)
      : super(ChallengeCrudInitial()) {
    on<GetAllLocalChallenges>(_onGetAllLocalAchievements);
    on<SearchChallengeByLevel>(_onSearchByLevel);
    on<SearchChallengeByKeyWords>(_onSearchByKeyword);
    on<CheckHabitAchievement>(_onCheckAchievement);
  }

  final _appLogger = getIt.get<AppLogger>();

  FutureOr<void> _onGetAllLocalAchievements(
      GetAllLocalChallenges event, Emitter<ChallengeCrudState> emit) async {
    emit(ChallengeLoading());
    try {
      final achievements =
          await achievementRepository.getAllLocalAchievements();
      emit(AllChallengeGot(achievements));
    } catch (e) {
      _appLogger.e(e);
      emit(ChallengeCrudFailed("Failed to load local achievements"));
    }
  }

  FutureOr<void> _onSearchByLevel(
      SearchChallengeByLevel event, Emitter<ChallengeCrudState> emit) async {
    emit(ChallengeLoading());
    try {
      final achievements =
          await achievementRepository.getAllLocalAchievements();
      final desiredAchievements =
          achievements.where((e) => e.achievementLevel == event.level).toList();
      emit(AllChallengeGot(desiredAchievements));
    } catch (e) {
      _appLogger.e(e);
      emit(ChallengeCrudFailed("Failed to search achievements by level"));
    }
  }

  FutureOr<void> _onSearchByKeyword(
      SearchChallengeByKeyWords event, Emitter<ChallengeCrudState> emit) async {
    emit(ChallengeLoading());
    try {
      final achievements =
          await achievementRepository.getAllLocalAchievements();
      final desiredAchievements = achievements
          .where((e) =>
              e.achievementName
                  .toLowerCase()
                  .contains(event.keyword.toLowerCase()) ||
              e.achievementDesc
                  .toLowerCase()
                  .contains(event.keyword.toLowerCase()))
          .toList();
      emit(AllChallengeGot(desiredAchievements));
    } catch (e) {
      _appLogger.e(e);
      emit(ChallengeCrudFailed("Failed to search achievements by keyword"));
    }
  }

  FutureOr<void> _onCheckAchievement(
      CheckHabitAchievement event, Emitter<ChallengeCrudState> emit) async {
    try {
      final habit = event.habit;
      final allAchievements =
          await achievementRepository.getAllLocalAchievements();
      final unlockedAchievements = <AchievementEntity>[];
    } catch (e) {
      _appLogger.e(e);
      emit(ChallengeCrudFailed('Failed to check achievement'));
    }
  }

  bool _checkAchievementCondition(
      HabitEntity habit, AchievementEntity achievement) {
    // if (habit.habitGoal.goalUnit == GoalUnit.l ||
    //     habit.habitGoal.goalUnit == GoalUnit.ml ||
    //     habit.habitGoal.goalUnit == GoalUnit.glasses) {
    //   final requirement = achievement.achievementRequirement;
    //   if (requirement is AccumulationRequirement) {
    //     if (requirement.unit == GoalUnit.l ||
    //         requirement.unit == GoalUnit.ml ||
    //         requirement.unit == GoalUnit.glasses) {
    //       return requirement.target == habit.
    //     }
    //   }
    // }
    return false;
  }
}
