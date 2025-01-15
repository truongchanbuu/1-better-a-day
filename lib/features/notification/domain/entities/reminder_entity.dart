import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/reminder/reminder_status.dart';
import '../../../habit/domain/entities/habit_frequency.dart';

class ReminderEntity extends Equatable {
  final String reminderId;
  final String habitId;
  final String reminderTitle;
  final DateTime reminderTime;
  final HabitFrequency? frequency;
  final ReminderStatus reminderStatus;

  const ReminderEntity({
    required this.reminderId,
    required this.reminderTitle,
    required this.habitId,
    required this.reminderTime,
    this.frequency,
    required this.reminderStatus,
  });

  factory ReminderEntity.init() {
    return ReminderEntity(
      reminderId: const Uuid().v4(),
      reminderTitle: '',
      habitId: '',
      reminderTime: DateTime.now(),
      reminderStatus: ReminderStatus.active,
    );
  }

  ReminderEntity copyWith({
    String? reminderId,
    String? reminderTitle,
    String? habitId,
    DateTime? reminderTime,
    ValueGetter<HabitFrequency?>? frequency,
    ReminderStatus? reminderStatus,
  }) {
    return ReminderEntity(
      reminderId: reminderId ?? this.reminderId,
      reminderTitle: reminderTitle ?? this.reminderTitle,
      habitId: habitId ?? this.habitId,
      reminderTime: reminderTime ?? this.reminderTime,
      frequency: frequency != null ? frequency() : this.frequency,
      reminderStatus: reminderStatus ?? this.reminderStatus,
    );
  }

  @override
  List<Object?> get props {
    return [
      reminderId,
      reminderTitle,
      habitId,
      reminderTime,
      frequency,
      reminderStatus,
    ];
  }
}
