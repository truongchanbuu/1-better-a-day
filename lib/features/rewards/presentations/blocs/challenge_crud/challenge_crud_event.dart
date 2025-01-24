part of 'challenge_crud_bloc.dart';

sealed class ChallengeCrudEvent extends Equatable {
  const ChallengeCrudEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllLocalChallenges extends ChallengeCrudEvent {}

final class SearchByFilters extends ChallengeCrudEvent {
  final AchievementLevel? level;
  final bool? isUnlocked;
  const SearchByFilters({this.level, this.isUnlocked});

  @override
  List<Object?> get props => [level, isUnlocked];
}

final class SearchChallengeByKeyWords extends ChallengeCrudEvent {
  final String keyword;
  const SearchChallengeByKeyWords(this.keyword);

  @override
  List<Object> get props => [keyword];
}

final class UpdateAchievement extends ChallengeCrudEvent {
  final GoalUnit habitUnit;
  final num value;
  const UpdateAchievement({required this.habitUnit, required this.value});

  @override
  List<Object> get props => [habitUnit, value];
}
