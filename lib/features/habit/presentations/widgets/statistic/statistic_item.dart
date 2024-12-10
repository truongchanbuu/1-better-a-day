import 'package:flutter/material.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';

class StatisticItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? subTitleColor;
  final String? figure;
  final Color? figureColor;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final Widget? leading;

  const StatisticItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.leading,
    this.subTitleColor,
    this.figure,
    this.figureColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grayBackgroundColor,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: ListTile(
        leading: leading,
        titleAlignment: ListTileTitleAlignment.center,
        isThreeLine: figure != null,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.grayText,
            fontSize: AppFontSize.h4,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subTitle,
              style: TextStyle(
                color: subTitleColor,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h2,
              ),
            ),
            if (figure != null)
              Text(
                figure!,
                style: TextStyle(
                  fontSize: AppFontSize.bodyLarge,
                  color: figureColor ?? AppColors.grayText,
                ),
              )
          ],
        ),
        trailing: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
