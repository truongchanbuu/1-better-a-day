import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/habit_icon.dart';

class PickIconField extends StatelessWidget {
  final HabitIcon? habitIcon;
  final VoidCallback? onPickIcon;
  const PickIconField({super.key, required this.habitIcon, this.onPickIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickIcon,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(AppSpacing.paddingM),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.marginS),
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSpacing.radiusM)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          children: [
            Iconify(
              habitIcon?.icon ?? Mdi.circle,
              color: habitIcon?.color ?? AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.marginS),
            Text(S.current.pick_icon),
          ],
        ),
      ),
    );
  }
}
