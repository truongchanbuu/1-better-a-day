import 'package:flutter/material.dart';

import '../../features/settings/presentations/pages/settings_page.dart';
import '../../generated/l10n.dart';

enum TabType { notifications, settings }

extension TabTypeExtension on TabType {
  String get title {
    switch (this) {
      case TabType.notifications:
        return S.current.notifications;
      case TabType.settings:
        return S.current.settings;
    }
  }

  IconData get icon {
    switch (this) {
      case TabType.notifications:
        return Icons.notifications;
      case TabType.settings:
        return Icons.settings;
    }
  }

  Widget get page {
    switch (this) {
      case TabType.settings:
        return const SettingsPage();
      case TabType.notifications:
        return Container(color: Colors.red);
    }
  }
}
