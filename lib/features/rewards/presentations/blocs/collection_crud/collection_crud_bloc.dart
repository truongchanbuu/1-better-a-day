import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/log/app_logger.dart';
import '../../../../../core/enums/rewards/achievement_level.dart';
import '../../../../../core/enums/rewards/achievement_type.dart';
import '../../../../../core/helpers/enum_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/achievement_model.dart';
import '../../../domain/entities/achievements/achievement_entity.dart';
import '../../../domain/entities/achievements/pre_defined/pre_defined_achievements.dart';
import '../../../domain/repositories/achievement_repository.dart';

part 'collection_crud_event.dart';
part 'collection_crud_state.dart';

class CollectionCrudBloc
    extends Bloc<CollectionCrudEvent, CollectionCrudState> {
  final AchievementRepository achievementRepository;

  CollectionCrudBloc(this.achievementRepository)
      : super(CollectionCrudInitial()) {
    on<LoadCollectionData>(_onLoadCollectionData);
  }

  final _appLogger = getIt.get<AppLogger>();

  FutureOr<void> _onLoadCollectionData(
    LoadCollectionData event,
    Emitter<CollectionCrudState> emit,
  ) async {
    try {
      emit(CollectionLoading());

      List<AchievementModel> localAchievements =
          await achievementRepository.getAllLocalAchievements();

      final totalCompletedAchievements =
          localAchievements.where((e) => e.isUnlocked).toList();

      final sortedAchievedByUnlockedDate = totalCompletedAchievements
        ..sortedByCompare((e) => e.unlockedDate, (a, b) {
          if (a == null) {
            return -1;
          } else if (b == null) {
            return 1;
          }

          return a.compareTo(b);
        }).toList();

      final levelStats = Map.fromEntries(
        AchievementLevel.values.map((level) {
          final total = PreDefinedAchievements.allAchievements
              .where((e) => e.achievementLevel == level)
              .length;
          final completed = localAchievements
              .where((e) => e.achievementLevel == level && e.isUnlocked)
              .length;
          return MapEntry(
              level, AchievementLevelStats(total: total, completed: completed));
        }),
      );

      emit(CollectionLoaded(
          totalAchievements: totalCompletedAchievements.length,
          levelStats: levelStats,
          completedAchievements: totalCompletedAchievements,
          firstAchievedChallenge: sortedAchievedByUnlockedDate.firstOrNull,
          lastAchievedChallenge: sortedAchievedByUnlockedDate.lastOrNull,
          mostAchievedLevel: EnumHelper.getMostFrequentEnumValue(
            totalCompletedAchievements,
            (AchievementEntity achievement) => achievement.achievementLevel,
          ),
          mostAchievedType: EnumHelper.getMostFrequentEnumValue(
            totalCompletedAchievements,
            (AchievementEntity achievement) => achievement.achievementType,
          )));
    } catch (e) {
      _appLogger.e(e);
      emit(CollectionLoadedFailed(S.current.not_found));
    }
  }
}

class AchievementLevelStats {
  final int total;
  final int completed;

  AchievementLevelStats({
    required this.total,
    required this.completed,
  });

  String get progressText => '$completed/$total';
}
