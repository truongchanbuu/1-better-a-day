import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/icon_with_text.dart';
import '../../blocs/distance_track/distance_track_cubit.dart';

class DistanceTracker extends StatelessWidget {
  const DistanceTracker({super.key});

  static const _spacing = SizedBox(height: AppSpacing.marginM);

  static const _titleSize = AppFontSize.bodyLarge;
  static const _valueSize = AppFontSize.labelLarge;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistanceTrackCubit, DistanceTrackState>(
      builder: (context, state) {
        bool isPlaying = state is DistanceUpdated || state is DistanceTracking;

        return Column(
          children: [
            _DistanceInfo(
              icon: FontAwesomeIcons.personWalking,
              title: S.current.current_distance,
              value: '1.6 km',
              color: Colors.purple,
              titleSize: _titleSize,
              valueSize: _valueSize,
            ),
            _spacing,
            _DistanceInfo(
              icon: FontAwesomeIcons.route,
              title: S.current.total_distance,
              value: '1.6 km',
              color: Colors.indigo,
              titleSize: _titleSize,
              valueSize: _valueSize,
            ),
            _spacing,
            ElevatedButton(
              key: ValueKey('distance_track_btn_$isPlaying'),
              onPressed: isPlaying
                  ? context.read<DistanceTrackCubit>().stopTracking
                  : context.read<DistanceTrackCubit>().startTracking,
              style: ElevatedButton.styleFrom(
                backgroundColor: isPlaying ? Colors.red : AppColors.primary,
              ),
              child: IconWithText(
                icon:
                    isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                text: isPlaying
                    ? S.current.pause_tracking
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