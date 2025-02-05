import 'dart:async';

import 'package:flutter/material.dart';

import '../blocs/habit_progress/habit_progress_bloc.dart';

class HabitProgressObserver extends WidgetsBindingObserver {
  Timer? _midnightTimer;
  final HabitProgressBloc habitProgressBloc;
  final _progressControllers = <StreamController<void>>{};

  HabitProgressObserver(this.habitProgressBloc) {
    WidgetsBinding.instance.addObserver(this);
    _checkAndUpdateHabitStatus();
  }

  StreamSubscription<void> addListener(void Function() onFunction) {
    final controller = StreamController<void>.broadcast();
    _progressControllers.add(controller);

    return controller.stream.listen((_) => onFunction());
  }

  void _notifyListeners() {
    for (final controller in _progressControllers) {
      controller.add(null);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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

    Timer(
      Duration(milliseconds: millisUntilMidnight),
      () {
        _checkAndUpdateHabitStatus();
      },
    );
  }

  void dispose() {
    for (var controller in _progressControllers) {
      controller.close();
    }

    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
  }

  void _checkAndUpdateHabitStatus() {
    habitProgressBloc.add(CheckHabitDaily());
    _notifyListeners();
  }
}
