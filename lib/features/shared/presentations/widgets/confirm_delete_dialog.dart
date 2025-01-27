import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../generated/l10n.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  const ConfirmDeleteDialog({super.key, this.onDelete, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.current.delete_title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.h3,
        ),
      ),
      content: Text(
        S.current.delete_warning,
        style: const TextStyle(
          fontSize: AppFontSize.bodyLarge,
        ),
        maxLines: 10,
        overflow: TextOverflow.visible,
      ),
      actions: [
        TextButton(
          onPressed: onCancel ??
              () {
                Navigator.of(context).pop(false);
              },
          child: Text(
            S.current.cancel_button,
            style: const TextStyle(
              color: AppColors.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: onDelete ??
              () {
                Navigator.of(context).pop(true);
              },
          style: TextButton.styleFrom(overlayColor: Colors.red),
          child: Text(
            S.current.delete_button,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
