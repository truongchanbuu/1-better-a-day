import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';

class SmartTooltip extends StatelessWidget {
  const SmartTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _TooltipItem(
            title: 'S - Specific',
            desc: S.current.specify_desc,
          ),
          const Divider(),
          _TooltipItem(
            title: 'M - Measurable',
            desc: S.current.measurement_desc,
          ),
          const Divider(),
          _TooltipItem(
            title: 'A - Achievable',
            desc: S.current.achievable_desc,
          ),
          const Divider(),
          _TooltipItem(
            title: 'R - Relevant',
            desc: S.current.relevant_desc,
          ),
          const Divider(),
          _TooltipItem(
            title: 'T - Time-bound',
            desc: S.current.time_bound_desc,
          ),
        ],
      ),
    );
  }
}

class _TooltipItem extends StatelessWidget {
  final String title;
  final String desc;
  const _TooltipItem({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.bodyLarge,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.marginXS),
        Text(
          desc,
          style: const TextStyle(fontSize: AppFontSize.labelLarge),
          maxLines: 10,
        ),
      ],
    );
  }
}
