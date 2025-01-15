import 'package:flutter/material.dart';

import '../../../../../core/constants/app_font_size.dart';
import '../../../../../generated/l10n.dart';

class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Enable Notifications',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.h3,
        ),
      ),
      content: const Text(
        'To help you build better habits, we\'d like to send you reminders. '
        'Would you like to enable notifications?',
        overflow: TextOverflow.visible,
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(S.current.not_now_button),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(S.current.enable_button),
        ),
      ],
    );
  }
}
