import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/habit/presentations/pages/all_habits_page.dart';
import '../../features/notification/presentations/pages/notification_page.dart';
import '../../features/settings/presentations/pages/settings_page.dart';
import '../../generated/l10n.dart';
import '../constants/app_color.dart';

enum TabType {
  notifications,
  settings,
  habits;

  String get title {
    switch (this) {
      case TabType.notifications:
        return S.current.notifications;
      case TabType.settings:
        return S.current.settings;
      case TabType.habits:
        return S.current.all_habits;
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
        return const NotificationPage();
      case TabType.habits:
        return const AllHabitsPage();
    }
  }

  Widget get trailing => switch (this) {
        TabType.notifications => IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.circlePlus,
              color: AppColors.lightText,
            ),
          ),
        TabType.settings => const SizedBox.shrink(),
        TabType.habits => const SizedBox.shrink(),
      };
}
