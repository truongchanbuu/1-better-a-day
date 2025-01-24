import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../../../core/enums/rewards/achievement_level.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/achievement_model.dart';
import '../../../domain/entities/achievements/achievement_entity.dart';
import '../../../domain/repositories/achievement_repository.dart';
import '../../helpers/achievement_matcher.dart';
import '../../helpers/requirement_handler.dart';

part 'challenge_crud_event.dart';
part 'challenge_crud_state.dart';

class ChallengeCrudBloc extends Bloc<ChallengeCrudEvent, ChallengeCrudState> {
  final AchievementRepository achievementRepository;

  ChallengeCrudBloc(this.achievementRepository)
      : super(ChallengeCrudInitial()) {
    on<GetAllLocalChallenges>(_onGetAllLocalAchievements);
    on<SearchByFilters>(_onSearchByFilter);
    on<SearchChallengeByKeyWords>(_onSearchByKeyword);
    on<UpdateAchievement>(_onUpdateAchievement);
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

  FutureOr<void> _onSearchByFilter(
      SearchByFilters event, Emitter<ChallengeCrudState> emit) async {
    emit(ChallengeLoading());
    try {
      List<AchievementEntity> desiredAchievements =
          (await achievementRepository.getAllLocalAchievements())
              .map((e) => e.toEntity())
              .toList();

      if (event.level != null) {
        desiredAchievements = desiredAchievements
            .where((e) => e.achievementLevel == event.level)
            .toList();
      }

      if (event.isUnlocked != null) {
        desiredAchievements = desiredAchievements
            .where((e) => e.isUnlocked == event.isUnlocked)
            .toList();
      }

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

  FutureOr<void> _onUpdateAchievement(
      UpdateAchievement event, Emitter<ChallengeCrudState> emit) async {
    try {
      List<AchievementModel> achievements =
          await achievementRepository.getAllLocalAchievements();

      achievements = achievements.where((e) => !e.isUnlocked).toList();

      final matcher = AchievementMatcher();
      final matchingAchievements =
          await matcher.findMatchingAchievements(achievements, event.habitUnit);

      final handlers = [
        AccumulationHandler(),
        TimeRequirementHandler(),
        StreakHandler(),
      ];

      for (var achievement in matchingAchievements) {
        final handler = handlers.firstWhere(
          (h) => h.canHandle(achievement.achievementRequirement),
          orElse: () => throw FormatException('Invalid achievement type'),
        );

        double normalizeValue = event.value.toDouble();
        if (event.habitUnit != achievement.achievementRequirement.baseUnit) {
          normalizeValue = UnitConverter.normalizeValue(
            event.habitUnit,
            event.value.toDouble(),
          );
        }

        final updatedRequirement = handler.processUpdate(
          achievement.achievementRequirement,
          event.habitUnit,
          normalizeValue,
        );

        if (updatedRequirement.isCompleted) {
          final unlockedAchievement = achievement.copyWith(
            achievementRequirement: updatedRequirement,
            isUnlocked: true,
            unlockedDate: DateTime.now(),
          );

          await achievementRepository.updateAchievement(
            AchievementModel.fromEntity(unlockedAchievement),
          );
          emit(ChallengeUnlocked(unlockedAchievement));
        }
      }
    } catch (e) {
      _appLogger.e('Error updating achievement: $e');
      emit(ChallengeCrudFailed('Failed to check achievement'));
    }
  }
}
