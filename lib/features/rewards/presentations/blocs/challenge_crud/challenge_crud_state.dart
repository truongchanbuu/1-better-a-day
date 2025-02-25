part of 'challenge_crud_bloc.dart';

sealed class ChallengeCrudState extends Equatable {
  const ChallengeCrudState();

  @override
  List<Object> get props => [];
}

final class ChallengeCrudInitial extends ChallengeCrudState {}

final class AllChallengeGot extends ChallengeCrudState {
  final List<AchievementEntity> achievements;
  const AllChallengeGot(this.achievements);

  @override
  List<Object> get props => [achievements];
}

final class ChallengeUpdated extends ChallengeCrudState {
  final AchievementEntity achievement;
  const ChallengeUpdated(this.achievement);

  @override
  List<Object> get props => [achievement];
}

final class ChallengeUnlocked extends ChallengeCrudState {
  final AchievementEntity achievement;
  const ChallengeUnlocked(this.achievement);

  @override
  List<Object> get props => [achievement];
}

final class ChallengeCrudFailed extends ChallengeCrudState {
  final String errorMessage;
  const ChallengeCrudFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class ChallengeLoading extends ChallengeCrudState {}
