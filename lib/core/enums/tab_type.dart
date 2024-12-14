import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/habit/presentations/pages/all_habits_page.dart';
import '../../features/habit/presentations/pages/today_page.dart';
import '../../features/notification/presentations/pages/notification_page.dart';
import '../../features/rewards/presentations/pages/challenge_page.dart';
import '../../features/settings/presentations/pages/settings_page.dart';
import '../../generated/l10n.dart';
import '../constants/app_color.dart';

enum TabType {
  today,
  notifications,
  settings,
  habits,
  challenges;

  String get title {
    switch (this) {
      case TabType.today:
        return S.current.today;
      case TabType.notifications:
        return S.current.notifications;
      case TabType.settings:
        return S.current.settings;
      case TabType.habits:
        return S.current.all_habits;
      case TabType.challenges:
        return S.current.challenges_screen;
    }
  }

  IconData get icon {
    switch (this) {
      case TabType.today:
        return FontAwesomeIcons.circleDot;
      case TabType.notifications:
        return Icons.notifications;
      case TabType.settings:
        return Icons.settings;
      case TabType.habits:
        return Icons.list;
      case TabType.challenges:
        return FontAwesomeIcons.mountain;
    }
  }

  Widget get page {
    switch (this) {
      case TabType.today:
        return const TodayPage();
      case TabType.settings:
        return const SettingsPage();
      case TabType.notifications:
        return const NotificationPage();
      case TabType.habits:
        return const AllHabitsPage();
      case TabType.challenges:
        return const ChallengesPage();
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
        TabType.today => const SizedBox.shrink(),
        TabType.challenges => IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.circlePlus,
              color: AppColors.lightText,
            ),
          ),
      };
}
