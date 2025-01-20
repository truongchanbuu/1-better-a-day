part of 'collection_crud_bloc.dart';

sealed class CollectionCrudState extends Equatable {
  const CollectionCrudState();

  @override
  List<Object?> get props => [];
}

final class CollectionCrudInitial extends CollectionCrudState {}

final class CollectionLoading extends CollectionCrudState {}

final class CollectionLoaded extends CollectionCrudState {
  final int totalAchievements;
  final AchievementEntity? lastAchievedChallenge;
  final AchievementEntity? firstAchievedChallenge;
  final AchievementLevel? mostAchievedLevel;
  final AchievementType? mostAchievedType;
  final Map<AchievementLevel, AchievementLevelStats> levelStats;
  final List<AchievementEntity> completedAchievements;

  const CollectionLoaded({
    required this.totalAchievements,
    required this.levelStats,
    required this.completedAchievements,
    this.lastAchievedChallenge,
    this.firstAchievedChallenge,
    this.mostAchievedLevel,
    this.mostAchievedType,
  });

  @override
  List<Object?> get props => [
        totalAchievements,
        levelStats,
        completedAchievements,
        lastAchievedChallenge,
        firstAchievedChallenge,
        mostAchievedLevel,
        mostAchievedType,
      ];
}

final class CollectionLoadedFailed extends CollectionCrudState {
  final String message;
  const CollectionLoadedFailed(this.message);
  @override
  List<Object> get props => [message];
}
