import 'package:flutter/material.dart';

import '../../../../core/enums/habit_frequency.dart';
import '../../domain/enitites/habit_entity.dart';

final habit1 = HabitEntity(
  habitId: '1',
  habitTitle: 'Morning Exercise',
  habitDesc: 'Do a 30-minute workout every morning.',
  habitGoal: 'Stay fit and healthy',
  duration: Duration(minutes: 30),
  frequency: HabitFrequency.daily.name,
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
  reminderTime: DateTime(2024, 1, 1, 6, 0),
  habitStatus: 'Active',
);

class HabitDetailPage extends StatelessWidget {
  // final HabitEntity habit;
  const HabitDetailPage({
    super.key,
    // required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(habit1.habitTitle),
    );
  }
}
