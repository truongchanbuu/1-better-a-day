import 'package:equatable/equatable.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';

import '../../../../../core/enums/rewards/achievement_level.dart';
import '../../../../../core/enums/rewards/achievement_type.dart';
import '../../../../habit/domain/entities/habit_icon.dart';
import 'achievement_requirement.dart';
import 'streak_requirement.dart';

class AchievementEntity extends Equatable {
  final String? userEmail;
  final String achievementId;
  final String achievementName;
  final String achievementDesc;
  final AchievementType achievementType;
  final AchievementRequirement achievementRequirement;
  final bool isUnlocked;
  final HabitIcon achievementIcon;
  final AchievementLevel achievementLevel;
  final DateTime? unlockedDate;

  const AchievementEntity({
    required this.achievementId,
    required this.achievementName,
    required this.achievementDesc,
    required this.achievementType,
    required this.achievementRequirement,
    required this.isUnlocked,
    required this.achievementIcon,
    required this.achievementLevel,
    this.unlockedDate,
    this.userEmail,
  });

  factory AchievementEntity.init() {
    return AchievementEntity(
      achievementId: '',
      achievementName: '',
      achievementDesc: '',
      achievementType: AchievementType.streak,
      achievementRequirement: StreakRequirement(requiredDays: 0),
      isUnlocked: false,
      achievementIcon: HabitIcon(key: 'default', icon: Mdi.circle),
      achievementLevel: AchievementLevel.common,
    );
  }

  bool get isCommon => achievementLevel == AchievementLevel.common;
  bool get isRare => achievementLevel == AchievementLevel.rare;
  bool get isEpic => achievementLevel == AchievementLevel.epic;
  bool get isLegendary => achievementLevel == AchievementLevel.legendary;

  AchievementEntity copyWith({
    String? achievementId,
    String? achievementName,
    String? achievementDesc,
    AchievementType? achievementType,
    AchievementRequirement? achievementRequirement,
    bool? isUnlocked,
    HabitIcon? achievementIcon,
    DateTime? unlockedDate,
    AchievementLevel? achievementLevel,
    String? userEmail,
  }) {
    return AchievementEntity(
      achievementId: achievementId ?? this.achievementId,
      achievementName: achievementName ?? this.achievementName,
      achievementDesc: achievementDesc ?? this.achievementDesc,
      achievementType: achievementType ?? this.achievementType,
      achievementRequirement:
          achievementRequirement ?? this.achievementRequirement,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      achievementIcon: achievementIcon ?? this.achievementIcon,
      unlockedDate: unlockedDate ?? this.unlockedDate,
      achievementLevel: achievementLevel ?? this.achievementLevel,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  @override
  List<Object?> get props {
    return [
      achievementId,
      achievementName,
      achievementDesc,
      achievementType,
      achievementRequirement,
      isUnlocked,
      achievementIcon,
      unlockedDate,
      achievementLevel,
      userEmail,
    ];
  }
}
