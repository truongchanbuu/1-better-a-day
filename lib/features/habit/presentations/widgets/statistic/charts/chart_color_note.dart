import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../generated/l10n.dart';

class ChartColorNote extends StatelessWidget {
  const ChartColorNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        _ColorNote(
          color: AppColors.success,
          title: S.current.achieved_habit,
        ),
        _ColorNote(
          color: AppColors.error,
          title: S.current.failed_habit,
        ),
        _ColorNote(
          color: AppColors.warning,
          title: S.current.paused_habit,
        ),
        _ColorNote(
          color: AppColors.primary,
          title: S.current.in_progress_habit,
        ),
      ],
    );
  }
}

class _ColorNote extends StatelessWidget {
  final Color color;
  final String title;

  const _ColorNote({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: AppSpacing.marginS),
        Text(title)
      ],
    );
  }
}
