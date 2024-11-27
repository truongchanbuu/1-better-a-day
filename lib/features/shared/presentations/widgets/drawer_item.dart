import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';

class DrawerItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData iconData;
  final bool isSelected;

  const DrawerItem({
    super.key,
    required this.iconData,
    required this.title,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isSelected ? Colors.white : AppColors.primary;
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusS),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          iconData,
          color: textColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
