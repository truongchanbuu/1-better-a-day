import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';

class TextWithCircleBorderContainer extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double? width;

  const TextWithCircleBorderContainer({
    super.key,
    required this.title,
    this.backgroundColor,
    this.titleColor,
    this.fontSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.circleRadius),
        color: (backgroundColor ?? AppColors.primary).withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingM,
        vertical: AppSpacing.paddingXS,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor ?? backgroundColor ?? AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
