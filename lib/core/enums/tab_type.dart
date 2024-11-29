import 'package:flutter/material.dart';

import '../../features/habit/presentations/pages/all_habits_page.dart';
import '../../features/settings/presentations/pages/settings_page.dart';
import '../../generated/l10n.dart';

enum TabType { notifications, settings, habits }

extension TabTypeExtension on TabType {
  String get title {
    switch (this) {
      case TabType.notifications:
        return S.current.notifications;
      case TabType.settings:
        return S.current.settings;
      case TabType.habits:
        return S.current.habits;
    }
  }

  IconData get icon {
    switch (this) {
      case TabType.notifications:
        return Icons.notifications;
      case TabType.settings:
        return Icons.settings;
      case TabType.habits:
        return Icons.list;
    }
  }

  Widget get page {
    switch (this) {
      case TabType.settings:
        return const SettingsPage();
      case TabType.notifications:
        return Container(color: Colors.red);
      case TabType.habits:
        return const AllHabitsPage();
    }
  }
}
