import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _sectionTextStyle =
      TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold);
  static const _titleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.labelLarge);
  static const _subTitleTextStyle = TextStyle(fontSize: AppFontSize.labelSmall);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        // Time of day
        SettingsSection(
          title: Text(
            S.current.time_of_day_section,
            style: _sectionTextStyle,
          ),
          tiles: [
            SettingsTile.navigation(
              title: Text(S.current.dawn_tile, style: _titleTextStyle),
              value: const Text('6:00'),
              description: const Text('6:00', style: _subTitleTextStyle),
              leading: const Icon(Icons.wb_sunny, color: Colors.orange),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title: Text(S.current.afternoon_tile, style: _titleTextStyle),
              value: const Text('12:00'),
              description: const Text('12:00', style: _subTitleTextStyle),
              leading: const Icon(Icons.cloud, color: Colors.blueAccent),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title: Text(S.current.dusk_tile, style: _titleTextStyle),
              value: const Text('18:00'),
              description: const Text('18:00', style: _subTitleTextStyle),
              leading: const Icon(Icons.brightness_2, color: Colors.yellow),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
          ],
        ),

        // General
        SettingsSection(
          title: Text(
            S.current.general_section,
            style: _sectionTextStyle,
          ),
          tiles: [
            SettingsTile.navigation(
              title: Text(S.current.language_tile, style: _titleTextStyle),
              value: Text(S.current.english_choice),
              description:
                  Text(S.current.english_choice, style: _subTitleTextStyle),
              leading: const Icon(Icons.language, color: Colors.blue),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title: Text(S.current.theme_tile, style: _titleTextStyle),
              value: Text(S.current.light_theme),
              description:
                  Text(S.current.light_theme, style: _subTitleTextStyle),
              leading: const Icon(Icons.light_mode, color: Colors.amber),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title: Text(
                S.current.measurement_unit_title,
                style: _titleTextStyle,
              ),
              value: Text(S.current.metric_unit),
              description:
                  Text(S.current.metric_unit, style: _subTitleTextStyle),
              leading: const Icon(Icons.straighten, color: Colors.orange),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
          ],
        ),

        // Account
        SettingsSection(
          title: Text(S.current.account_section, style: _sectionTextStyle),
          tiles: [
            SettingsTile.navigation(
              title:
                  Text(S.current.authentication_choice, style: _titleTextStyle),
              leading: const Icon(Icons.login, color: Colors.blue),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.primary,
              ),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
          ],
        ),

        // App Info
        SettingsSection(
          title: Text(S.current.app_info_section, style: _sectionTextStyle),
          tiles: [
            SettingsTile.navigation(
              title:
                  Text(S.current.terms_and_conditions, style: _titleTextStyle),
              leading: const Icon(Icons.description),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.primary,
              ),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title: Text(S.current.help_tile, style: _titleTextStyle),
              leading: const Icon(Icons.help, color: Colors.deepPurpleAccent),
              backgroundColor: AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
      ],
    );
  }
}
