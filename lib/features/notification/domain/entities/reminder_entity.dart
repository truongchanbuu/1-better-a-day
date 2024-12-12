import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ReminderEntity extends Equatable {
  final String reminderId;
  final String reminderTitle;
  final String habitId;
  final String? desc;
  final DateTime reminderTime;
  final String? frequency;
  final String reminderStatus;
  final int habitStreak;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const ReminderEntity({
    required this.reminderId,
    required this.reminderTitle,
    required this.habitId,
    this.desc,
    required this.reminderTime,
    this.frequency,
    required this.reminderStatus,
    required this.habitStreak,
    required this.createdAt,
    this.updatedAt,
  });

  ReminderEntity copyWith({
    String? reminderId,
    String? reminderTitle,
    String? habitId,
    ValueGetter<String?>? desc,
    DateTime? reminderTime,
    ValueGetter<String?>? frequency,
    String? reminderStatus,
    int? habitStreak,
    DateTime? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return ReminderEntity(
      reminderId: reminderId ?? this.reminderId,
      reminderTitle: reminderTitle ?? this.reminderTitle,
      habitId: habitId ?? this.habitId,
      desc: desc != null ? desc() : this.desc,
      reminderTime: reminderTime ?? this.reminderTime,
      frequency: frequency != null ? frequency() : this.frequency,
      reminderStatus: reminderStatus ?? this.reminderStatus,
      habitStreak: habitStreak ?? this.habitStreak,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      reminderId,
      reminderTitle,
      habitId,
      desc,
      reminderTime,
      frequency,
      reminderStatus,
      habitStreak,
      createdAt,
      updatedAt,
    ];
  }
}
