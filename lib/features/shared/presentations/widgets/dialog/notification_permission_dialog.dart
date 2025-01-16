import 'package:flutter/material.dart';

import '../../../../../core/constants/app_font_size.dart';
import '../../../../../generated/l10n.dart';

class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.current.enable_notifications,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.h3,
        ),
      ),
      content: Text(
        S.current.notification_permission_request,
        overflow: TextOverflow.visible,
        maxLines: 4,
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
