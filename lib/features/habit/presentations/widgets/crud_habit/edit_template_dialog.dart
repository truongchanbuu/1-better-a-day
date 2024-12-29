import 'package:flutter/material.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';

class EditTemplateDialog extends StatelessWidget {
  final Widget child;
  const EditTemplateDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusM)),
      ),
      height: MediaQuery.of(context).size.height - 280,
      margin: const EdgeInsets.all(AppSpacing.marginM),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}