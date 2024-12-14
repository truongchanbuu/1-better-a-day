import 'package:equatable/equatable.dart';

import '../achievement_requirement.dart';

class AchievementEntity extends Equatable {
  final String achievementId;
  final String achievementName;
  final String achievementDesc;
  final String achievementType;
  final AchievementRequirement achievementRequirement;
  final bool isUnlocked;
  final String achievementIcon;
  final String achievementLevel;
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
  });

  AchievementEntity copyWith({
    String? achievementId,
    String? achievementName,
    String? achievementDesc,
    String? achievementType,
    AchievementRequirement? achievementRequirement,
    bool? isUnlocked,
    String? achievementIcon,
    DateTime? unlockedDate,
    String? achievementLevel,
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
    ];
  }
}
