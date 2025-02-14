import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../../blocs/habit_time_tracker/habit_time_tracker_bloc.dart';

// TODO: STORE WITH HISTORY
class TimeTracker extends StatefulWidget {
  const TimeTracker({
    super.key,
    required this.historyId,
    required this.targetValue,
    required this.goalUnit,
  });

  final String historyId;
  final GoalUnit? goalUnit;
  final double targetValue;

  @override
  State<TimeTracker> createState() => _TimeTrackerState();
}

class _TimeTrackerState extends State<TimeTracker> {
  void _handleResume(BuildContext context) {
    context.read<HabitTimeTrackerBloc>().add(ResumeTracking());
  }

  void _handleInit(BuildContext context) {
    context.read<HabitTimeTrackerBloc>().add(TimeTrackingInit());
  }

  void _handleCompletion(BuildContext context) {
    context.read<HabitHistoryCrudBloc>().add(SetHabitHistoryStatus(
          historyId: widget.historyId,
          status: DayStatus.completed,
        ));
  }

  void _handlePause(BuildContext context) {
    context.read<HabitTimeTrackerBloc>().add(PauseTracking());
  }

  void _handleRestart(BuildContext context) {
    context.read<HabitTimeTrackerBloc>().add(RestartTracking());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitTimeTrackerBloc, HabitTimeTrackerState>(
      listener: (context, state) {
        if (state is TimeTrackSucceed) {
          _handleCompletion(context);
        }
      },
      child: Column(
        children: [
          BlocBuilder<HabitTimeTrackerBloc, HabitTimeTrackerState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.marginS),
                child: CircularPercentIndicator(
                  radius: 100,
                  center: Text(
                    DateTimeHelper.getTimeTrackerFromSecond(state.currentTime),
                    style: const TextStyle(fontSize: AppFontSize.h4),
                  ),
                  lineWidth: 25,
                  backgroundColor: Colors.black12,
                  progressColor: AppColors.primary,
                  progressBorderColor: AppColors.primary,
                  percent: state.currentTime / state.targetTime,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<HabitTimeTrackerBloc, HabitTimeTrackerState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      state is TimePaused || state is TimeInitial
                          ? Icons.play_arrow
                          : Icons.pause,
                    ),
                    onPressed: state is TimeInitial
                        ? () => _handleInit(context)
                        : state is TimeTracking
                            ? () => _handlePause(context)
                            : () => _handleResume(context),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.repeat),
                onPressed: () => _handleRestart(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
