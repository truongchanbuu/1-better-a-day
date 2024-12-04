import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';

class HabitSectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? width;

  const HabitSectionContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding ?? const EdgeInsets.all(AppSpacing.paddingM),
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (context.isDarkMode ? AppColors.darkText : AppColors.lightText),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 5,
            color: AppColors.grayBackgroundColor,
          ),
        ],
      ),
      child: child,
    );
  }
}
