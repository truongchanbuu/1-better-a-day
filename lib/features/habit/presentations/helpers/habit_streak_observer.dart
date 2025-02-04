import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../core/helpers/cached_client.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';

class HabitStreakObserver extends WidgetsBindingObserver {
  final HabitHistoryCrudBloc habitHistoryCrudBloc;
  final CacheClient cachedClient;
  Timer? _midnightTimer;
  final _streakUpdateControllers = <StreamController<void>>{};

  static const String lastCheckDateKey = 'last_check_date';

  HabitStreakObserver({
    required this.habitHistoryCrudBloc,
    required this.cachedClient,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _checkAndUpdateStreaks();
    _setupMidnightTimer();
  }

  StreamSubscription<void> addListener(void Function() onStreakUpdate) {
    final controller = StreamController<void>.broadcast();
    _streakUpdateControllers.add(controller);

    return controller.stream.listen((_) => onStreakUpdate());
  }

  void _notifyListeners() {
    for (final controller in _streakUpdateControllers) {
      controller.add(null);
    }
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
    final lastCheckTimestamp = cachedClient.getInt(lastCheckDateKey);
    if (lastCheckTimestamp == null) {
      cachedClient.setInt(lastCheckDateKey, now.millisecondsSinceEpoch);
      return;
    }

    final lastCheckDate =
        DateTime.fromMillisecondsSinceEpoch(lastCheckTimestamp);

    final lastCheckDay = DateTime(
      lastCheckDate.year,
      lastCheckDate.month,
      lastCheckDate.day,
    );

    final today = DateTime(now.year, now.month, now.day);

    if (today.isAfter(lastCheckDay)) {
      habitHistoryCrudBloc.add(CheckDailyStreaks());
      cachedClient.setInt(lastCheckDateKey, now.millisecondsSinceEpoch);
      _notifyListeners();
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
    for (final controller in _streakUpdateControllers) {
      controller.close();
    }
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
  }
}
