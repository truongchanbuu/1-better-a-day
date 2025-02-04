import 'dart:async';

import 'package:flutter/material.dart';

import '../blocs/habit_progress/habit_progress_bloc.dart';

class HabitProgressObserver extends WidgetsBindingObserver {
  Timer? _midnightTimer;
  final HabitProgressBloc habitProgressBloc;

  HabitProgressObserver(this.habitProgressBloc) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _setupMidnightTimer();
    } else if (state == AppLifecycleState.paused) {
      _midnightTimer?.cancel();
    }
  }

  void _setupMidnightTimer() {
    _midnightTimer?.cancel();

    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final millisUntilMidnight = tomorrow.difference(now).inMilliseconds;

    _midnightTimer = Timer(
      Duration(milliseconds: millisUntilMidnight),
      () {
        _setupMidnightTimer();
        _checkAndUpdateHabitStatus();
      },
    );
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
  }

  void _checkAndUpdateHabitStatus() {
    habitProgressBloc.add(CheckHabitDaily());
  }
}
