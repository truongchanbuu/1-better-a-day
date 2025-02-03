import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../core/helpers/cached_client.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';

class HabitStreakObserver extends WidgetsBindingObserver {
  final HabitHistoryCrudBloc habitHistoryCrudBloc;
  final CacheClient cachedClient;
  Timer? _midnightTimer;
  static const String lastCheckDateKey = 'last_check_date';

  HabitStreakObserver({
    required this.habitHistoryCrudBloc,
    required this.cachedClient,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _checkAndUpdateStreaks();
    _setupMidnightTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndUpdateStreaks();
      _setupMidnightTimer();
    } else if (state == AppLifecycleState.paused) {
      _midnightTimer?.cancel();
    }
  }

  void _checkAndUpdateStreaks() {
    final now = DateTime.now();
    final lastCheckDate = DateTime.fromMillisecondsSinceEpoch(
      cachedClient.getInt(lastCheckDateKey) ?? now.millisecondsSinceEpoch,
    );

    final lastCheckDay = DateTime(
      lastCheckDate.year,
      lastCheckDate.month,
      lastCheckDate.day,
    );

    final today = DateTime(now.year, now.month, now.day);

    if (today.isAfter(lastCheckDay)) {
      habitHistoryCrudBloc.add(CheckDailyStreaks());
      cachedClient.setInt(lastCheckDateKey, now.millisecondsSinceEpoch);
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
        _checkAndUpdateStreaks();
        _setupMidnightTimer();
      },
    );
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
  }
}
