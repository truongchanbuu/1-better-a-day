part of 'challenge_crud_bloc.dart';

sealed class ChallengeCrudEvent extends Equatable {
  const ChallengeCrudEvent();

  @override
  List<Object> get props => [];
}

final class GetAllLocalChallenges extends ChallengeCrudEvent {}

final class SearchChallengeByLevel extends ChallengeCrudEvent {
  final AchievementLevel level;
  const SearchChallengeByLevel(this.level);

  @override
  List<Object> get props => [level];
}

final class SearchChallengeByKeyWords extends ChallengeCrudEvent {
  final String keyword;
  const SearchChallengeByKeyWords(this.keyword);

  @override
  List<Object> get props => [keyword];
}

final class CheckHabitAchievement extends ChallengeCrudEvent {
  final HabitEntity habit;
  const CheckHabitAchievement(this.habit);

  @override
  List<Object> get props => [habit];
}
