import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/icon_with_text.dart';
import '../../blocs/distance_track/distance_track_cubit.dart';
import '../../blocs/habit_history_crud/habit_history_crud_bloc.dart';

// TODO: STORE THE CURRENT TO HISTORY
class DistanceTracker extends StatelessWidget {
  final String historyId;
  final double targetDistance;

  const DistanceTracker({
    super.key,
    required this.historyId,
    required this.targetDistance,
  });

  static const _spacing = SizedBox(height: AppSpacing.marginM);

  static const _titleSize = AppFontSize.bodyLarge;
  static const _valueSize = AppFontSize.labelLarge;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistanceTrackCubit, DistanceTrackState>(
      listener: (context, state) {
        if (state is DistanceTrackError) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: S.current.failure_title,
            desc: state.errorMessage,
          ).show();
        } else if (state is DistanceTrackSucceed) {
          _handleSucceed(context);
        }
      },
      builder: (context, state) {
        bool isPlaying = state is DistanceTracking;

        return Column(
          children: [
            _DistanceInfo(
              icon: FontAwesomeIcons.personWalking,
              title: S.current.current_distance,
              value: '${state.currentDistance.toStringAsFixedWithoutZero()} m',
              color: Colors.purple,
              titleSize: _titleSize,
              valueSize: _valueSize,
            ),
            _spacing,
            _DistanceInfo(
              icon: FontAwesomeIcons.route,
              title: S.current.total_distance,
              value: '${targetDistance.toStringAsFixedWithoutZero()} m',
              color: Colors.indigo,
              titleSize: _titleSize,
              valueSize: _valueSize,
            ),
            _spacing,
            ElevatedButton(
              key: ValueKey('distance_track_btn_$isPlaying'),
              onPressed: isPlaying
                  ? context.read<DistanceTrackCubit>().stopTracking
                  : state is DistanceTrackInitial
                      ? context.read<DistanceTrackCubit>().initializeService
                      : context.read<DistanceTrackCubit>().startTracking,
              style: ElevatedButton.styleFrom(
                  backgroundColor: isPlaying ? Colors.red : AppColors.primary),
              child: IconWithText(
                icon:
                    isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                text: isPlaying
                    ? S.current.stop_tracking
                    : S.current.start_tracking,
                fontColor: AppColors.lightText,
                iconColor: AppColors.lightText,
                fontSize: AppFontSize.h4,
                iconSize: 20,
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleSucceed(BuildContext context) {
    context.read<HabitHistoryCrudBloc>().add(SetHabitHistoryStatus(
          historyId: historyId,
          status: DayStatus.completed,
        ));
  }
}

class _DistanceInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final double? titleSize;
  final double? valueSize;

  const _DistanceInfo({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.titleSize,
    this.valueSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconWithText(
          icon: icon,
          text: title,
          iconColor: color,
          fontColor: color,
          fontSize: titleSize,
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: valueSize,
          ),
        ),
      ],
    );
  }
}
