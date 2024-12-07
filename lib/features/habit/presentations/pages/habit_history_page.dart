import 'package:flutter/material.dart';

import '../../../../core/enums/habit_status.dart';
import '../../../../core/enums/mood.dart';
import '../../../../core/helpers/setting_helper.dart';
import '../../../../generated/l10n.dart';
import '../../domain/enitites/goal_unit.dart';
import '../../domain/enitites/habit_history.dart';

final logs = [
  HabitHistory(
    id: '1',
    habitId: 'habit1',
    date: DateTime(2024, 1, 1),
    status: HabitStatus.completed.name,
    startTime: DateTime(2024, 1, 1, 7, 0),
    endTime: DateTime(2024, 1, 1, 8, 0),
    duration: const Duration(hours: 1),
    note: 'Great start to the year!',
    rating: 5,
    mood: Mood.good.name,
    quantity: 1.0,
    measurement: GoalUnit.m.name,
  ),
  HabitHistory(
    id: '2',
    habitId: 'habit2',
    date: DateTime(2024, 1, 2),
    status: 'failed',
    startTime: DateTime(2024, 1, 2, 8, 0),
    endTime: DateTime(2024, 1, 2, 9, 0),
    duration: const Duration(hours: 1),
    note: 'Missed the target.',
    rating: 2,
    mood: 'Sad',
    quantity: 1.0,
    measurement: 'hour',
  )
];

class HabitHistoryPage extends StatelessWidget {
  const HabitHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(S.current.history_section)),
        body: SingleChildScrollView(),
      ),
    );
  }
}
