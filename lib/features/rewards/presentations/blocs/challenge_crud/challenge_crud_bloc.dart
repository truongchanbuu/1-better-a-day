import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/enums/rewards/achievement_level.dart';
import '../../../domain/entities/achievements/achievement_entity.dart';
import '../../../domain/entities/achievements/pre_defined/pre_defined_achievements.dart';

part 'challenge_crud_event.dart';
part 'challenge_crud_state.dart';

class ChallengeCrudBloc extends Bloc<ChallengeCrudEvent, ChallengeCrudState> {
  ChallengeCrudBloc() : super(ChallengeCrudInitial()) {
    on<GetAllLocalChallenges>(_onGetAllLocalAchievements);
    on<SearchChallengeByLevel>(_onSearchByLevel);
    on<SearchChallengeByKeyWords>(_onSearchByKeyword);
  }

  FutureOr<void> _onGetAllLocalAchievements(
      GetAllLocalChallenges event, Emitter<ChallengeCrudState> emit) {
    emit(ChallengeLoading());
    emit(AllChallengeGot(PreDefinedAchievements.allAchievements));
  }

  FutureOr<void> _onSearchByLevel(
      SearchChallengeByLevel event, Emitter<ChallengeCrudState> emit) {
    emit(ChallengeLoading());
    final desiredAchievements = PreDefinedAchievements.allAchievements
        .where((e) => e.achievementLevel == event.level)
        .toList();

    emit(AllChallengeGot(desiredAchievements));
  }

  FutureOr<void> _onSearchByKeyword(
      SearchChallengeByKeyWords event, Emitter<ChallengeCrudState> emit) {
    emit(ChallengeLoading());
    final desiredAchievements = PreDefinedAchievements.allAchievements
        .where((e) =>
            e.achievementName.toLowerCase().contains(event.keyword) ||
            e.achievementDesc.toLowerCase().contains(event.keyword))
        .toList();
    emit(AllChallengeGot(desiredAchievements));
  }
}
