import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ant_design.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/enums/habit/goal_type.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../domain/entities/habit_goal.dart';
import '../../../domain/entities/habit_history.dart';
import '../../blocs/distance_track/distance_track_cubit.dart';
import '../../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../../blocs/habit_time_tracker/habit_time_tracker_bloc.dart';
import '../../helper/shared_habit_action.dart';
import 'distance_tracker.dart';
import 'progress_tracker.dart';
import 'time_tracker.dart';

class HabitTracker extends StatefulWidget {
  final String habitId;
  final HabitGoal habitGoal;

  const HabitTracker({
    super.key,
    required this.habitId,
    required this.habitGoal,
  });

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  late final RoundedLoadingButtonController _doneBtnController;
  late final RoundedLoadingButtonController _pauseBtnController;

  late DayStatus trackStatus;

  late GoalUnit _goalUnit;
  late GoalType _goalType;
  late HabitGoal _habitGoal;

  late HabitHistory history;

  @override
  void initState() {
    super.initState();
    context.read<HabitHistoryCrudBloc>().add(
          GetTodayHabitHistory(
            habitId: widget.habitId,
            unit: widget.habitGoal.goalUnit,
            targetValue: widget.habitGoal.targetValue,
          ),
        );

    trackStatus = DayStatus.inProgress;
    _habitGoal = widget.habitGoal;
    _goalUnit = _habitGoal.goalUnit;
    _goalType = _habitGoal.goalType;

    _doneBtnController = RoundedLoadingButtonController();
    _pauseBtnController = RoundedLoadingButtonController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitHistoryCrudBloc, HabitHistoryCrudState>(
      listener: (context, state) {
        if (state is DailyHabitCompleted) {
          trackStatus = DayStatus.completed;

          SharedHabitAction.showDailyCompletionDialog(
            context: context,
            status: trackStatus.name,
          );
        } else if (state is DailyHabitPaused) {
          trackStatus = DayStatus.skipped;

          SharedHabitAction.showDailyCompletionDialog(
            context: context,
            status: trackStatus.name,
          );
        }
      },
      child: BlocBuilder<HabitHistoryCrudBloc, HabitHistoryCrudState>(
        buildWhen: (previous, current) => current is HabitHistoryCrudSuccess,
        builder: (context, state) {
          if (state is! HabitHistoryCrudSuccess || state.histories.isEmpty) {
            return const SizedBox.shrink();
          }

          history = state.histories.first;
          if ([DayStatus.completed, DayStatus.skipped]
              .contains(history.executionStatus)) {
            bool isCompleted = history.executionStatus == DayStatus.completed;
            return Center(
              child: Iconify(
                isCompleted
                    ? AntDesign.check_circle_fill
                    : AntDesign.pause_circle_fill,
                color: isCompleted ? Colors.green : Colors.amber,
                size: 40,
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTracker(),
              const SizedBox(height: AppSpacing.marginS),
              _buildCompletionTracker(),
            ],
          );
        },
      ),
    );
  }

  Widget _getTracker() {
    if (_goalUnit == GoalUnit.l || _goalUnit == GoalUnit.ml) {
      return _buildWaterDrinkingTracker();
    } else if (_goalType == GoalType.duration ||
        _goalUnit == GoalUnit.minutes ||
        _goalUnit == GoalUnit.second) {
      return _buildTimerTracker();
    } else if (_goalType == GoalType.distance) {
      return _buildDistanceTracker();
    }

    return const SizedBox.shrink();
  }

  Widget _buildDistanceTracker() {
    double targetDistance = _habitGoal.targetValue;
    if (_goalUnit == GoalUnit.km) {
      targetDistance *= 1000;
    } else if (_goalUnit == GoalUnit.miles) {
      targetDistance *= 1600;
    } else if (_goalUnit == GoalUnit.cm) {
      targetDistance /= 100;
    }

    return BlocProvider(
      create: (context) =>
          getIt.get<DistanceTrackCubit>(param1: targetDistance),
      child: DistanceTracker(
        historyId: history.id,
        targetDistance: targetDistance,
      ),
    );
  }

  Widget _buildTimerTracker() {
    int time = _habitGoal.targetValue.toInt();
    if (_goalUnit == GoalUnit.minutes) {
      time *= 60;
    } else if (_goalUnit == GoalUnit.hour) {
      time *= 3600;
    } else if (_goalUnit == GoalUnit.day) {
      time *= 3600 * 24;
    }

    return BlocProvider(
      create: (context) => getIt.get<HabitTimeTrackerBloc>(param1: time),
      child: TimeTracker(
        historyId: history.id,
        targetValue: _habitGoal.targetValue,
        goalUnit: _goalUnit,
      ),
    );
  }

  Widget _buildWaterDrinkingTracker() {
    return ProgressTracker(
      habitId: widget.habitId,
      goalType: GoalType.completion,
      currentValue: history.currentValue,
      targetValue: _habitGoal.targetValue,
      goalUnit: _goalUnit,
      isActionButtonShown: (trackStatus != DayStatus.completed &&
              trackStatus != DayStatus.skipped) ||
          trackStatus == DayStatus.inProgress,
    );
  }

  Widget _buildCompletionTracker() {
    return Column(
      children: [
        _buildDoneButton(),
        const SizedBox(height: AppSpacing.marginS),
        _buildPauseButton(),
      ],
    );
  }

  static const Color _labelColor = Colors.white;

  Widget _buildDoneButton() {
    return _buildActionButton(
      statusCondition: DayStatus.completed,
      targetStatus: DayStatus.completed,
      icon: FontAwesomeIcons.circleCheck,
      title: S.current.mark_as_done,
      backgroundColor: AppColors.primary,
      onPressed: () {
        setState(() {
          _habitGoal =
              _habitGoal.copyWith(currentValue: _habitGoal.targetValue);
        });

        context.read<HabitHistoryCrudBloc>().add(SetHabitHistoryStatus(
              historyId: history.id,
              status: DayStatus.completed,
            ));
      },
    );
  }

  Widget _buildPauseButton() {
    return _buildActionButton(
      statusCondition: DayStatus.skipped,
      targetStatus: DayStatus.skipped,
      icon: FontAwesomeIcons.circlePause,
      title: S.current.mark_as_pause,
      backgroundColor: AppColors.warning,
      successColor: AppColors.warning,
      onPressed: () {
        context.read<HabitHistoryCrudBloc>().add(SetHabitHistoryStatus(
              historyId: history.id,
              status: DayStatus.skipped,
            ));
      },
    );
  }

  Widget _buildActionButton({
    required DayStatus statusCondition,
    required DayStatus targetStatus,
    required IconData icon,
    required String title,
    required Function() onPressed,
    Color backgroundColor = Colors.transparent,
    Color? successColor,
  }) {
    final isVisible =
        trackStatus == statusCondition || trackStatus == DayStatus.inProgress;

    return AnimatedSwitcherPlus.translationRight(
      duration: const Duration(milliseconds: 500),
      child: isVisible
          ? _HabitActionButton(
              controller: targetStatus == DayStatus.completed
                  ? _doneBtnController
                  : _pauseBtnController,
              icon: icon,
              title: title,
              labelColor: _labelColor,
              successColor: successColor,
              backgroundColor: backgroundColor,
              onPressed: () async {
                setState(() => trackStatus = targetStatus);

                onPressed();
                await Future.delayed(const Duration(seconds: 1));
                if (targetStatus == DayStatus.completed) {
                  _doneBtnController.success();
                } else {
                  _pauseBtnController.success();
                }
              },
            )
          : const SizedBox.shrink(),
    );
  }
}

class _HabitActionButton extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final IconData icon;
  final String title;
  final Color? backgroundColor;
  final Color labelColor;
  final Color? successColor;
  final VoidCallback? onPressed;

  const _HabitActionButton({
    required this.controller,
    required this.icon,
    required this.title,
    required this.labelColor,
    this.backgroundColor,
    this.successColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      width: MediaQuery.of(context).size.width,
      controller: controller,
      color: backgroundColor ??
          (context.isDarkMode ? AppColors.primaryDark : AppColors.primary),
      onPressed: onPressed,
      errorColor: AppColors.error,
      successColor: successColor ?? AppColors.success,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: labelColor),
          const SizedBox(width: AppSpacing.marginS),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }
}
