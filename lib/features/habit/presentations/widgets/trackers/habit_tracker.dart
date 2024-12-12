import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/day_status.dart';
import '../../../../../core/enums/goal_type.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/goal_unit.dart';
import '../../../domain/entities/habit_goal.dart';
import '../../blocs/distance_track/distance_track_cubit.dart';
import '../../pages/habit_detail_page.dart';
import 'distance_tracker.dart';
import 'progress_tracker.dart';
import 'time_tracker.dart';

class HabitTracker extends StatefulWidget {
  final HabitGoal habitGoal;

  const HabitTracker({super.key, required this.habitGoal});

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

  @override
  void initState() {
    super.initState();
    trackStatus = DayStatus.inProgress;
    _habitGoal = widget.habitGoal;
    _goalUnit = GoalUnit.fromString(_habitGoal.goalUnit);
    _goalType = GoalType.fromString(_habitGoal.goalType);

    _doneBtnController = RoundedLoadingButtonController();
    _pauseBtnController = RoundedLoadingButtonController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getTracker(),
        const SizedBox(height: AppSpacing.marginM),
        _buildCompletionTracker(),
      ],
    );
  }

  Widget _getTracker() {
    switch (_goalType) {
      case GoalType.count:
        if (_goalUnit == GoalUnit.l || _goalUnit == GoalUnit.ml) {
          return _buildWaterDrinkingTracker();
        }

        return Container();
      case GoalType.duration:
        return _buildTimerTracker();
      case GoalType.distance:
        return _buildDistanceTracker();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDistanceTracker() {
    return BlocProvider(
      create: (context) =>
          getIt.get<DistanceTrackCubit>(param1: widget.habitGoal.targetValue),
      child: const DistanceTracker(),
    );
  }

  Widget _buildTimerTracker() {
    return TimeTracker(
      targetValue: _habitGoal.targetValue,
      goalUnit: _goalUnit,
    );
  }

  Widget _buildWaterDrinkingTracker() {
    return ProgressTracker(
      goalType: GoalType.fromString(habit.habitGoal.goalType),
      currentValue: _habitGoal.currentValue,
      targetValue: _habitGoal.targetValue,
      goalUnit: _goalUnit,
      isActionButtonShown: (trackStatus != DayStatus.completed &&
              trackStatus != DayStatus.paused) ||
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
      },
    );
  }

  Widget _buildPauseButton() {
    return _buildActionButton(
      statusCondition: DayStatus.paused,
      targetStatus: DayStatus.paused,
      icon: FontAwesomeIcons.circlePause,
      title: S.current.mark_as_pause,
      backgroundColor: AppColors.warning,
      successColor: AppColors.warning,
      onPressed: () {},
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
