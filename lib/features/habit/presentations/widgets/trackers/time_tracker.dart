import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/helpers/duration_helper.dart';
import '../../../domain/entities/goal_unit.dart';

class TimeTracker extends StatefulWidget {
  final GoalUnit? goalUnit;
  final double targetValue;

  const TimeTracker({
    super.key,
    required this.targetValue,
    required this.goalUnit,
  });

  @override
  State<TimeTracker> createState() => _TimeTrackerState();
}

class _TimeTrackerState extends State<TimeTracker> {
  late final CountDownController _countDownController;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _countDownController = CountDownController();
  }

  @override
  Widget build(BuildContext context) {
    final executionTime = DurationHelper.getDurationFromGoalUnit(
        widget.targetValue, widget.goalUnit);

    return Column(
      children: [
        NeonCircularTimer(
          onComplete: () {
            setState(() {
              _isPlaying = false;
            });
          },
          width: 200,
          duration: executionTime?.inSeconds ?? 0,
          controller: _countDownController,
          neon: 10,
          autoStart: false,
          innerFillGradient: LinearGradient(colors: [
            Colors.greenAccent.shade200,
            Colors.blueAccent.shade400
          ]),
          neonGradient: LinearGradient(colors: [
            Colors.greenAccent.shade200,
            Colors.blueAccent.shade400
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.marginM)
              .copyWith(bottom: AppSpacing.marginS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (_isPlaying) {
                    _countDownController.pause();
                  } else {
                    _countDownController.resume();
                  }

                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.repeat),
                onPressed: () {
                  _countDownController.restart();
                  setState(() {
                    _isPlaying = true;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
