import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_storage_key.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/setting_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import '../../../auth/presentations/bloc/login/login_cubit.dart';
import '../../../auth/presentations/bloc/signup/signup_cubit.dart';
import '../../../auth/presentations/pages/auth_page.dart';
import '../../../habit/presentations/pages/more_habit_knowledge_page.dart';
import '../../../user/presentations/bloc/update_info_cubit.dart';
import '../../../user/presentations/pages/profile_page.dart';
import '../bloc/settings_cubit.dart';
import '../widgets/setting_selection_bottom_sheet.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _sectionTextStyle =
      TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold);
  static const _titleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.labelLarge);
  static const _subTitleTextStyle = TextStyle(fontSize: AppFontSize.labelSmall);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);
    final defaultSettings =
        context.select((SettingsCubit settings) => settings.state);

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
              value: Text(defaultSettings.dawn),
              description:
                  Text(defaultSettings.dawn, style: _subTitleTextStyle),
              leading: const Icon(Icons.wb_sunny, color: Colors.orange),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: (context) => _onSelectTimeOfDay(
                  context, AppStorageKey.appDawnTimeCachedKey),
            ),
            SettingsTile.navigation(
              title: Text(S.current.afternoon_tile, style: _titleTextStyle),
              value: Text(defaultSettings.afternoon),
              description:
                  Text(defaultSettings.afternoon, style: _subTitleTextStyle),
              leading: const Icon(Icons.cloud, color: Colors.blueAccent),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: (context) => _onSelectTimeOfDay(
                  context, AppStorageKey.appAfternoonTimeCachedKey),
            ),
            SettingsTile.navigation(
              title: Text(S.current.dusk_tile, style: _titleTextStyle),
              value: Text(defaultSettings.dusk),
              description:
                  Text(defaultSettings.dusk, style: _subTitleTextStyle),
              leading: const Icon(Icons.brightness_2, color: Colors.yellow),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: (context) => _onSelectTimeOfDay(
                  context, AppStorageKey.appDuskTimeCachedKey),
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
              value: Text(
                  SettingHelper.langCodeToFullName(defaultSettings.language)),
              description: Text(
                SettingHelper.langCodeToFullName(defaultSettings.language),
                style: _subTitleTextStyle,
              ),
              leading: const Icon(Icons.language, color: Colors.blue),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: _onLangChanged,
            ),
            SettingsTile.navigation(
              title: Text(S.current.theme_tile, style: _titleTextStyle),
              value: Text(defaultSettings.isDarkMode
                  ? S.current.dark_theme
                  : S.current.light_theme),
              description: Text(
                  defaultSettings.isDarkMode
                      ? S.current.dark_theme
                      : S.current.light_theme,
                  style: _subTitleTextStyle),
              leading: defaultSettings.isDarkMode
                  ? const Icon(Icons.dark_mode, color: Colors.amber)
                  : const Icon(Icons.light_mode, color: Colors.amber),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: _onThemeChanged,
            ),
            SettingsTile.navigation(
              title: Text(
                S.current.measurement_unit_title,
                style: _titleTextStyle,
              ),
              value: Text(defaultSettings.measurementSystem ==
                      MeasurementSystem.metric.name
                  ? S.current.metric_unit
                  : S.current.imperial_unit),
              description: Text(
                  defaultSettings.measurementSystem ==
                          MeasurementSystem.metric.name
                      ? S.current.metric_unit
                      : S.current.imperial_unit,
                  style: _subTitleTextStyle),
              leading: const Icon(Icons.straighten, color: Colors.orange),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: _onMeasurementSystemChanged,
            ),
          ],
        ),

        // Account
        SettingsSection(
          title: Text(S.current.account_section, style: _sectionTextStyle),
          tiles: [
            !currentUser.isLoggedIn
                ? SettingsTile.navigation(
                    title: Text(
                      S.current.authentication_choice,
                      style: _titleTextStyle,
                    ),
                    leading: const Icon(Icons.login, color: Colors.blue),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.primary,
                    ),
                    backgroundColor: context.isDarkMode
                        ? AppColors.darkText
                        : AppColors.lightText,
                    onPressed: _authPage,
                  )
                : SettingsTile.navigation(
                    title: Text(S.current.manage_account_choice,
                        style: _titleTextStyle),
                    leading:
                        const Icon(Icons.manage_accounts, color: Colors.blue),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.primary,
                    ),
                    backgroundColor: context.isDarkMode
                        ? AppColors.darkText
                        : AppColors.lightText,
                    onPressed: _onManageAccount,
                  ),
          ],
        ),

        // Additional Info
        SettingsSection(
          title:
              Text(S.current.additional_information, style: _sectionTextStyle),
          tiles: [
            SettingsTile.navigation(
              title:
                  Text(S.current.terms_and_conditions, style: _titleTextStyle),
              leading: const Icon(Icons.description),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.primary,
              ),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title: Text(S.current.help_tile, style: _titleTextStyle),
              leading: const Icon(Icons.help, color: Colors.deepPurpleAccent),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              title:
                  Text(S.current.know_more_about_habit, style: _titleTextStyle),
              leading: const Icon(Icons.lightbulb, color: Colors.amber),
              backgroundColor:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              onPressed: onMoreKnowledgePage,
            ),
          ],
        ),

        // TODO: STORE REMOTELY

        // Logout
        if (currentUser.isLoggedIn)
          SettingsSection(
            tiles: [
              SettingsTile.navigation(
                title: Text(
                  S.current.logout_button.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: context.isDarkMode
                    ? AppColors.darkText
                    : AppColors.lightText,
                onPressed: _logout,
              ),
            ],
          ),
      ],
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequest());
  }

  void _authPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          ctx: context,
          type: PageTransitionType.fade,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt.get<LoginCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt.get<SignUpCubit>(),
              ),
            ],
            child: const AuthPage(),
          ),
          duration: AppCommons.pageTransitionDuration,
        ));
  }

  void _onSelectTimeOfDay(BuildContext context, String cachedKey) async {
    final settingCubit = context.read<SettingsCubit>();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return;

    final selectedTimeString = '${selectedTime.hour}:${selectedTime.minute}';
    settingCubit.timeChanged(cachedKey, selectedTimeString);
  }

  void _onLangChanged(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SettingSelectionBottomSheet<String>(
        choices: SettingHelper.supportedLanguages,
        selected: context.select((SettingsCubit settings) =>
            SettingHelper.langCodeToFullName(
                settings.currentLocale.languageCode)),
        onSelected: context.read<SettingsCubit>().languageChanged,
      ),
    );
  }

  void _onThemeChanged(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SettingSelectionBottomSheet<String>(
        choices: [S.current.light_theme, S.current.dark_theme],
        selected: context.select((SettingsCubit settings) =>
            settings.isDarkMode ? S.current.dark_theme : S.current.light_theme),
        onSelected: (choice) => context
            .read<SettingsCubit>()
            .themeChanged(choice == S.current.dark_theme),
      ),
    );
  }

  void _onMeasurementSystemChanged(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SettingSelectionBottomSheet<String>(
        choices: MeasurementSystem.values
            .map((system) => system.name.toUpperCaseFirstLetter)
            .toList(),
        selected: context.select((SettingsCubit settings) =>
            settings.state.measurementSystem.toUpperCaseFirstLetter),
        onSelected: (choice) => context
            .read<SettingsCubit>()
            .measurementSystemChanged(choice.toLowerCase()),
      ),
    );
  }

  void _onManageAccount(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          duration: AppCommons.pageTransitionDuration,
          child: BlocProvider(
            create: (context) => getIt.get<UpdateInfoCubit>(),
            child: const ProfilePage(),
          ),
          type: PageTransitionType.leftToRight,
        ));
  }

  void onMoreKnowledgePage(BuildContext context) => Navigator.push(
        context,
        PageTransition(
            child: const MoreHabitKnowledgePage(),
            type: PageTransitionType.leftToRight),
      );
}
